//
//  SignUpOptionsScreen.swift
//  YogiFi
//
//  Created by Kalyan Chakravarthi Pusuluri on 05/08/20.
//  Copyright © 2020 Kalyan Chakravarthi Pusuluri. All rights reserved.
//

import UIKit
import GoogleSignIn
import FBSDKLoginKit
import AuthenticationServices
import Lottie
import SwiftyJSON


protocol SignUpOptionsScreenDelegate {
    func handleSocialresponse(data:JSON?)
}

class SignUpOptionsScreen: UIViewController {
    
    @IBOutlet var yogifiAnimation: AnimationView!
    @IBOutlet weak var signUpAppleBtn: UIButton!
    @IBOutlet weak var signUpEmailBtn: UIButton!
    @IBOutlet weak var signUpGoogleBtn: UIButton!
    @IBOutlet weak var signUpFacebookBtn: UIButton!
    //var activityIndicator = UIActivityIndicatorView()
    @IBOutlet weak var termsBtn: UIButton!
    @IBOutlet weak var policyBtn: UIButton!
    
    var socialViewModel = SocialViewModel()
     var signInModel : SocialLoginModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        socialViewModel.signUpDelegate = self
        
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
        termsBtn.titleLabel?.underlineMyText(range1:"Terms and Conditions", range2:"")
        policyBtn.titleLabel?.underlineMyText(range1:"Privacy Policy", range2:"")
    }
    
    
    @IBAction func signUpWithGoogleAction(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signIn()
    }
   
    
    //Facebook Login
    @IBAction func signUpWithFacebookAction(_ sender: Any) {
        didSelectFBButton()
    }
    
    
  
    
    
    @IBAction func signUpWithAppleAction(_ sender: Any) {
    }
    
    
    @IBAction func pushBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
}

