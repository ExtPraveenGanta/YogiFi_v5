//
//  eMailVerificationScreen.swift
//  YogiFi
//
//  Created by Girish Nandagiri on 12/08/20.
//  Copyright © 2020 Girish Nandagiri. All rights reserved.
//

import UIKit
import Lottie
import  SwiftyJSON



protocol eMailVerificationScreenDelegate {
    func handleResponseForVerify(data:JSON?)
    func handleResponseForResend(data:JSON?)
}




class eMailVerificationScreen: UIViewController {

   
   
    @IBOutlet weak var otpTextFieldView: OTPFieldView!
    @IBOutlet weak var logoAnimation: AnimationView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var termsBtn: UIButton!
    @IBOutlet weak var policyBtn: UIButton!
     @IBOutlet weak var nextBtn: UIButton!
    var emailVerifyViewModel = EmailVerifyViewModel()
    var emailString:String?
    var otpString:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailLabel.text = emailString
        emailVerifyViewModel.emailDelegate = self
        setUpOtpField()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        logoAnimation.setupAnimationView(numberCircles: 3)
        termsBtn.titleLabel?.underlineMyText(range1:"Terms and Conditions", range2:"")
        policyBtn.titleLabel?.underlineMyText(range1:"Privacy Policy", range2:"")
    }

   
    @IBAction func backToLastScreen(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    @IBAction func next_action(_ sender: Any) {
        postVerifyRegisterCode()
    }
    
    @IBAction func resend_action(_ sender: Any) {
        YFLoadingIndicator.show(view:self.view)
        emailVerifyViewModel.postResendCode()
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
