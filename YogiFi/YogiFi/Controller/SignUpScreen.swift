//
//  SignUpScreen.swift
//  YogiFi
//
//  Created by Kalyan Chakravarthi Pusuluri on 05/08/20.
//  Copyright © 2020 Kalyan Chakravarthi Pusuluri. All rights reserved.
//

import UIKit
import Lottie
import AuthenticationServices
import SwiftyJSON

protocol SignUpScreenDelegate {
    func handleSocialresponse(data:JSON?)
}


class SignUpScreen: UIViewController {
    
    
    
    @IBOutlet weak var signUpWithAppleBtn: UIButton!
    @IBOutlet weak var signUpOptionsBtn: UIButton!
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var termsBtn: UIButton!
    @IBOutlet weak var policyBtn: UIButton!
    var animationView: AnimationView!
    var socialViewModel = SocialViewModel()
    var signInModel : SocialLoginModel?
    var auth = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        extensionMethods()
        socialViewModel.signUpScreenDelegate = self
        //setupAnimationView()
        
        
    }
    
    func setupAnimationView() {
        //Load animation
        let weightJsonName = "yogifiAnimation"
        let weightAnimation = Animation.named(weightJsonName)
        self.animationView = AnimationView(animation: weightAnimation)
        
        animationView.frame = CGRect(x: self.view.frame.size.width/2-80, y: 200, width: 160, height: 160 )
        self.view.addSubview(animationView)
        animationView.backgroundColor = .white
        
        // Set animation view content mode
        animationView.contentMode = .scaleAspectFit
        
        // Set animation loop mode
        animationView.loopMode = .loop
        
        self.view.backgroundColor = .clear
        //animationView.animationSpeed = 10.0
        let frameToProgress = 100.0
        //move to the frame
        self.animateFrame(to: CGFloat(frameToProgress))
        
    }
    func animateFrame(to frameValue:CGFloat) {
        // Play from frame A to frame B
        animationView.play(fromFrame: 0,
                           toFrame: frameValue,
                           loopMode: .playOnce)
    }
    
    
    private func extensionMethods(){
        
        signUpWithAppleBtn.titleLabel?.font = UIFont.textRegular16
        signUpOptionsBtn.titleLabel?.font = UIFont.textRegular16
        signInBtn.titleLabel?.font = UIFont.textRegular16
        termsBtn.titleLabel?.underlineMyText(range1:"Terms and Conditions", range2:"")
        policyBtn.titleLabel?.underlineMyText(range1:"Privacy Policy", range2:"")
    }
    
    
    
    @IBAction func terms_and_condition(_ sender: Any) {
        let storyBoard = UIStoryboard.init(name:"Main", bundle: nil)
        if let vc = storyBoard.instantiateViewController(withIdentifier: "YFWebViewScreen") as? YFWebViewScreen,
            let url = URL(string: "https://www.wellnesys.com/legal/") {
            vc.url = url
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func privacyPolicy(_ sender: Any) {
        let storyBoard = UIStoryboard.init(name:"Main", bundle: nil)
        if let vc = storyBoard.instantiateViewController(withIdentifier: "YFWebViewScreen") as? YFWebViewScreen,
            let url = URL(string: "https://www.wellnesys.com/privacy-policy/") {
            vc.url = url
            self.navigationController?.pushViewController(vc, animated: true)
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
    
    @IBAction func signUpWithApple(_ sender: Any) {
        if #available(iOS 13.0, *) {
            checkAuthorisationStatus(for:Constant.appleID ?? "")
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
}



extension SignUpScreen:ASAuthorizationControllerDelegate,ASAuthorizationControllerPresentationContextProviding
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
            socialViewModel.postAppleIDLogin(email,userName,"",userIdentifier,.signUp,auth)
        }
    }
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
    }
    
}



extension SignUpScreen:SignUpScreenDelegate
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

extension SignUpScreen
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
    
}

