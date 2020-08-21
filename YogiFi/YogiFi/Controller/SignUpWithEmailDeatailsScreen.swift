//
//  SignUpWithEmailDeatailsScreen.swift
//  YogiFi
//
//  Created by Girish Nandagiri on 06/08/20.
//  Copyright © 2020 Girish Nandagiri. All rights reserved.
//

import UIKit
import Lottie
import SwiftyJSON

protocol SWEDeatailsScreenDelegate {
    func handleRequestResponse(data:JSON?)
}


class SignUpWithEmailDeatailsScreen: UIViewController {
    @IBOutlet weak var logoAnimation: AnimationView!
    
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var termsBtn: UIButton!
    @IBOutlet weak var policyBtn: UIButton!
    var signUpDetailsViewModel = SignUpDetailsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        signUpDetailsViewModel.sWEDeatailsScreenDelegate = self
        extensionMethods()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        logoAnimation.setupAnimationView(numberCircles: 2)
    }

    

    private func extensionMethods(){
        firstNameTF.textField()
        lastNameTF.textField()
      termsBtn.titleLabel?.underlineMyText(range1:"Terms and Conditions", range2:"")
      policyBtn.titleLabel?.underlineMyText(range1:"Privacy Policy", range2:"")
    }
    
    @IBAction func backToLastScreen(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func next_action(_ sender: Any) {
       postStepOne()
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
