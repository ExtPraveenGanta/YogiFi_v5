//
//  SignUpWithEmailScreen.swift
//  YogiFi
//
//  Created by Girish Nandagiri on 05/08/20.
//  Copyright © 2020 Girish Nandagiri. All rights reserved.
//

import UIKit
import Lottie
import SwiftyJSON


protocol SignUpWithEmailScreenDelegate {
    func handleRegisterresponse(data:JSON?)
}


class SignUpWithEmailScreen: UIViewController {
    
    @IBOutlet weak var logoAnimation: AnimationView!
    @IBOutlet weak var showPasswordBtn: UIButton!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var createPasswordTF: UITextField!
    @IBOutlet weak var rememberMeImage: UIImageView!
    @IBOutlet weak var nextBtn: UIButton!
  @IBOutlet weak var termsBtn: UIButton!
  @IBOutlet weak var policyBtn: UIButton!
    
    var signUpViewModel = SignUpViewModel()
    var signUpModel:SignUpModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signUpViewModel.signUpDelegate = self
        extensionMethods()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        logoAnimation.setupAnimationView(numberCircles: 3)
    }
    private func extensionMethods(){
        emailTF.textField()
        createPasswordTF.textField()
        termsBtn.titleLabel?.underlineMyText(range1:"Terms and Conditions", range2:"")
        policyBtn.titleLabel?.underlineMyText(range1:"Privacy Policy", range2:"")
    }
    
    @IBAction func showPasswordAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            createPasswordTF.isSecureTextEntry = false
            showPasswordBtn.setImage(UIImage.init(named: "showPassword"), for: .normal)
        }
        else{
            createPasswordTF.isSecureTextEntry = true
            showPasswordBtn.setImage(UIImage.init(named: "hidePassword"), for: .normal)
        }
    }
    
    @IBAction func rememberMeAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            rememberMeImage.image = UIImage.init(named: "rememberMeChecked")
        }
        else{
            rememberMeImage.image = UIImage.init(named: "rememberMeUnchecked")
        }
    }
    
    @IBAction func backToLastScreen(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //Action method when next button is clicked
    @IBAction func next_action(_ sender: Any) {
       postRegister()
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



