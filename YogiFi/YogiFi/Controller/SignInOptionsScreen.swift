//
//  SignInOptionsScreen.swift
//  YogiFi
//
//  Created by NFCIndia on 19/08/20.
//  Copyright © 2020 GANTA PRAVEEN KUMAR. All rights reserved.
//

import UIKit
import GoogleSignIn
import FBSDKLoginKit
import AuthenticationServices
import SwiftyJSON

protocol SignInOptionsScreenDelegate {
    func handleSocialresponse(data:JSON?)
}



class SignInOptionsScreen: UIViewController {
    
    var socialViewModel = SocialViewModel()
    var signInModel : SocialLoginModel?
    var auth = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        socialViewModel.signInDelegate = self
        
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
    }
    
    
    @IBAction func signUpWithGoogleAction(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    
    //Facebook Login
    @IBAction func signUpWithFacebookAction(_ sender: Any) {
        didSelectFBButton()
    }
    
    
    @IBAction func signUpWithAppleAction(_ sender: Any) {
        if #available(iOS 13.0, *) {
            checkAuthorisationStatus(for:Constant.appleID ?? "")
        }
    }
    
    @IBAction func signIn_with_email(_ sender: Any) {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignInScreen") as? SignInScreen {
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
    
    
    @IBAction func back_action(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
