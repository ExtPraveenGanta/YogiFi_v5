//
//  DisplayNameScreen.swift
//  YogiFi
//
//  Created by Girish Nandagiri on 06/08/20.
//  Copyright © 2020 Girish Nandagiri. All rights reserved.
//

import UIKit
import Lottie

class DisplayNameScreen: UIViewController {
    
    @IBOutlet weak var logoAnimation: AnimationView!
    
    @IBOutlet weak var displayName: UITextField!
    @IBOutlet weak var nextBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        extensionMethods()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        logoAnimation.setupAnimationView(numberCircles: 3)
    }
    
    private func extensionMethods(){
        displayName.textField()
    }
    
    @IBAction func backToLastScreen(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func next_action(_ sender: Any) {
        UserStepTwo.shared.display_name = displayName.text
        pushToPersonalDetails()
    }
    
    func pushToPersonalDetails()
    {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PersonalDetails") as? PersonalDetails {
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
    
    @IBAction func skip_action(_ sender: Any) {
        pushToPersonalDetails()
    }
}


extension DisplayNameScreen:UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let userEnteredString = textField.text
        let newString = (userEnteredString! as NSString).replacingCharacters(in: range, with: string) as NSString
        if  newString != ""{
            nextBtn.backgroundColor = .tealish
            nextBtn.setTitleColor(.white, for:.normal)
        } else {
            nextBtn.backgroundColor = .white
            nextBtn.setTitleColor(.tealish, for:.normal)
        }
        return true
    }
}
