//
//  SignUpOptionsScreen+Extension.swift
//  YogiFi
//
//  Created by NFCIndia on 20/08/20.
//  Copyright © 2020 GANTA PRAVEEN KUMAR. All rights reserved.
//

import Foundation
import SwiftyJSON
import GoogleSignIn
import FBSDKLoginKit

extension SignUpOptionsScreen:SignUpOptionsScreenDelegate
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



extension SignUpOptionsScreen
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
    
    func socialAutherisation(_ userName: String, email: String, socialID: String, socialAccountType: String) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "WelcomeToYogiFiScreen") as? WelcomeToYogiFiScreen
        self.navigationController?.pushViewController(vc!, animated: true)
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
                    self.socialViewModel.postFbLogin(userEmail,first_name,last_name,.facebook,.signUp)
                    
                }
            })
        }
    }
    
}

extension SignUpOptionsScreen:LoginButtonDelegate
{
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if ((error) != nil) {
            // Process error
        }
        else if result!.isCancelled {
            // Handle cancellations
        }
        
    }
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        debugPrint("FB DidLogOut")
    }
    
}

extension SignUpOptionsScreen:GIDSignInDelegate
{
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if (error == nil) {
            print(user.profile.name as Any)
            print(user.profile.email as Any)
            
            YFLoadingIndicator.show(view:self.view)
            self.socialViewModel.postGmailLogin(user.profile.email,user.profile.name,"",.google,.signUp)
            
        } else {
            print("\(error.localizedDescription)")
        }
    }
    
}
