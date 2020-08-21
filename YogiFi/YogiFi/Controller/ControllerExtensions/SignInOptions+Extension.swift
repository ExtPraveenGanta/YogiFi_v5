//
//  SignInOptions+Extension.swift
//  YogiFi
//
//  Created by NFCIndia on 20/08/20.
//  Copyright © 2020 GANTA PRAVEEN KUMAR. All rights reserved.
//


import Foundation
import SwiftyJSON
import GoogleSignIn
import FBSDKLoginKit
import AuthenticationServices

extension SignInOptionsScreen:SignInOptionsScreenDelegate
{
    func handleSocialresponse(data: JSON?) {
        YFLoadingIndicator.hide(view:self.view)
        guard let response = data else {return}
        print(response)
        if response["code"].intValue == 200
        {
            if let model = parseUserDetails(with:response)
            { signInModel = model }
            Constant.accessToken = response["token"].stringValue
            Constant.name = (signInModel?.first_name ?? "") + " " + (signInModel?.last_name ?? "")
            if signInModel?.user?.profile_status    ==   -1
            {
                pushToStepOne()
            }
            else if signInModel?.user?.profile_status == 0
            {
                pushToStepTwo()
            }
            else if signInModel?.user?.profile_status == 1
            {
                pushToYogifiStatusScreen()
            }
        }
        else
        {
            self.show_alert(title:"", message:response["message"].stringValue)
        }
    }
    
}



extension SignInOptionsScreen
{
    //method to help extracting Data
    func parseUserDetails(with data:JSON?) -> SocialLoginModel? {
        if let responseDic = ParserHelper.retriveJsonObj(with: data) {
            if let theJSONData = try? JSONSerialization.data(withJSONObject: responseDic, options: []) {
                let decoder = JSONDecoder()
                do {
                    let info = try decoder.decode(SocialLoginModel.self, from: theJSONData)
                    return info
                } catch {
                    print(error)
                }
            }
        }
        return nil
    }
    
    
    func pushToStepOne()  {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignUpWithEmailDeatailsScreen") as? SignUpWithEmailDeatailsScreen {
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
    
    func pushToStepTwo() {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WelcomeToYogiFiScreen") as? WelcomeToYogiFiScreen {
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
    func pushToYogifiStatusScreen()
    {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "YogifiStatusScreen") as? YogifiStatusScreen {
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
    
    func didSelectFBButton() {
        let fbLoginManager : LoginManager = LoginManager()
        fbLoginManager.logIn(permissions: ["email"], from: self, handler: { (result, error) -> Void in
            if (error == nil) {
                let fbloginresult : LoginManagerLoginResult = result!
                if(fbloginresult.isCancelled) {
                } else if(fbloginresult.grantedPermissions.contains("email")) {
                    self.getUserFaceBookData()
                }
            }
            else{
                print("sdfdfd")
            }
        })
    }
    
    func getUserFaceBookData(){
        if((AccessToken.current) != nil){
            GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if ((error) != nil) {
                    // Process error
                    print("\n\n Error: \(error!)")
                } else {
                    var userName = ""
                    var userEmail = ""
                    var facebookID = ""
                    var first_name = ""
                    var last_name = ""
                    let resultDic = result as! NSDictionary
                    print("\n\n  fetched user: \(result ?? [])")
                    if (resultDic.value(forKey:"name") != nil) {
                        userName = resultDic.value(forKey:"name")! as! String
                        print("\n User Name is: \(userName)")
                    }
                    
                    if (resultDic.value(forKey:"email") != nil) {
                        userEmail = resultDic.value(forKey:"email")! as! String
                        print("\n User Email is: \(userEmail )")
                    }
                    
                    if (resultDic.value(forKey:"id") != nil) {
                        facebookID = resultDic.value(forKey:"id")! as! String
                        print("\n User Email is: \(facebookID )")
                    }
                    
                    if (resultDic.value(forKey:"first_name") != nil) {
                        first_name = resultDic.value(forKey:"first_name")! as! String
                        print("\n User first_name is: \(first_name )")
                    }
                    
                    if (resultDic.value(forKey:"last_name") != nil) {
                        last_name = resultDic.value(forKey:"last_name")! as! String
                        print("\n User last_name is: \(last_name)")
                    }
                    
                    YFLoadingIndicator.show(view:self.view)
                    self.socialViewModel.postFbLogin(userEmail,first_name,last_name,.facebook,.signIn)
                    
                }
            })
        }
    }
    
    
    func performExistingAccountSetupFlows() {
        // Prepare requests for both Apple ID and password providers.
        if #available(iOS 13.0, *) {
            let mailRequest = ASAuthorizationAppleIDProvider().createRequest()
            mailRequest.requestedScopes = [.email,.fullName]
            let requests = [mailRequest,
                            ASAuthorizationPasswordProvider().createRequest()]
            
            // Create an authorization controller with the given requests.
            let authorizationController = ASAuthorizationController(authorizationRequests: requests)
            
            authorizationController.delegate = self
            authorizationController.presentationContextProvider = self
            authorizationController.performRequests()
        } else {
            // Fallback on earlier versions
        }
        
    }
    @available(iOS 13.0, *)
    func checkAuthorisationStatus(for userID:String) {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        
        appleIDProvider.getCredentialState(forUserID: userID) { (credentialState, error) in
            switch credentialState {
            case .authorized:
                print("Apple ID credentialState is authorised")
                self.auth = true
                self.performExistingAccountSetupFlows()
            case .revoked, .notFound:
                // The Apple ID credential is either revoked or was not found, so show the sign-in UI.
                print("Apple ID credentialState credential is either revoked or was not found")
                self.auth = false
                self.signInWithApple()
            default:
                print("Apple ID credentialState unknown case")
                self.signInWithApple()
                self.auth = false
                break
            }
        }
    }
    func signInWithApple()  {
        if #available(iOS 13.0, *) {
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            request.requestedScopes = [.fullName, .email]
            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = self
            authorizationController.performRequests()
        } else {
            // Fallback on earlier versions
        }
    }
    
    
}

extension SignInOptionsScreen:LoginButtonDelegate
{
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        
    }
    
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if ((error) != nil) {
            // Process error
        }
        else if result!.isCancelled {
            // Handle cancellations
        }
        
    }
    
}

extension SignInOptionsScreen:GIDSignInDelegate
{
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if (error == nil) {
            print(user.profile.name as Any)
            print(user.profile.email as Any)
            
            YFLoadingIndicator.show(view:self.view)
            self.socialViewModel.postGmailLogin(user.profile.email,user.profile.name,"",.google,.signIn)
            
        } else {
            print("\(error.localizedDescription)")
        }
    }
    
}



extension SignInOptionsScreen:ASAuthorizationControllerDelegate,ASAuthorizationControllerPresentationContextProviding
{
    @available(iOS 13.0, *)
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as?  ASAuthorizationAppleIDCredential {
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            
            var userName:String = ""
            if let givenName = fullName?.givenName {
                print("givenName",givenName)
                userName = givenName
            }
            if let familyName = fullName?.familyName {
                print("familyName",familyName)
                userName.append(" ")
                userName.append(familyName)
            }
            Constant.appleID = userIdentifier
            print("User id is \(userIdentifier) \n Full Name is \(String(describing: fullName)) \n Email id is \(String(describing: email))")
            YFLoadingIndicator.show(view:self.view)
            socialViewModel.postAppleIDLogin(email,userName,"",userIdentifier,.signIn,auth)
        }
    }
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
    }
    
}
