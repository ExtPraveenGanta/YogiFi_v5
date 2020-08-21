//
//  SignInScreen.swift
//  YogiFi
//
//  Created by NFCIndia on 19/08/20.
//  Copyright © 2020 GANTA PRAVEEN KUMAR. All rights reserved.
//

import UIKit
import Lottie
import SwiftyJSON

protocol SignInScreenDelegate {
    func handleSignInResponsse(data:JSON?)
}


class SignInScreen: UIViewController {
    
    @IBOutlet weak var logoAnimation: AnimationView!
    @IBOutlet weak var showPasswordBtn: UIButton!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var createPasswordTF: UITextField!
    @IBOutlet weak var nextBtn: UIButton!
    
    var signInViewModel =  SignInViewModel()
    var signInModel : SignInModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        extensionMethods()
        signInViewModel.signInScreenDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           logoAnimation.setupAnimationView(numberCircles: 3)
       }
    private func extensionMethods(){
           emailTF.textField()
           createPasswordTF.textField()
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
    
    @IBAction func signIn_with_email(_ sender: Any) {
            postUserSignIn()
    }
       
       
       @IBAction func back_action(_ sender: Any) {
         self.navigationController?.popViewController(animated: true)
       }

}
