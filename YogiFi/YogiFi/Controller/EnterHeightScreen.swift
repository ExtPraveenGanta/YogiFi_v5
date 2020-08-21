//
//  EnterHeightScreen.swift
//  YogiFi
//
//  Created by Girish Nandagiri on 07/08/20.
//  Copyright © 2020 Girish Nandagiri. All rights reserved.
//

import UIKit
import Lottie

class EnterHeightScreen: UIViewController {
    
    @IBOutlet weak var logoAnimation: AnimationView!
    @IBOutlet weak var enterHeightTF: UITextField!
    @IBOutlet weak var cmBtn: UIButton!
    @IBOutlet weak var inchesBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    var heightPicker = UIPickerView()
    var heightsArray = [Int]()
    var selectedRow = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font :  UIFont.textRegular16
        ]
        enterHeightTF.attributedPlaceholder = NSAttributedString(string: "Enter Here", attributes:attributes)
        buttonTitleWithColor(button: inchesBtn)
        buttonTitleWithoutColor(button: cmBtn)
        
        setUpPicker()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        logoAnimation.setupAnimationView(numberCircles: 6)
    }
    
    
    func buttonTitleWithColor(button : UIButton) {
        button.titleLabel?.font = UIFont.textBold14
        button.setTitleColor(UIColor.tangerine, for: .normal)
    }
    func buttonTitleWithoutColor(button : UIButton) {
        button.titleLabel?.font = UIFont.textRegular12
        button.setTitleColor(UIColor.greyishBrown, for: .normal)
    }
    
    
    @IBAction func inchesOrcm(_ sender: UIButton) {
        if sender.titleLabel?.text == "Cms" {
            UserStepTwo.shared.height_unit = "Cms"
            buttonTitleWithColor(button: cmBtn)
            buttonTitleWithoutColor(button: inchesBtn)
        }
        else{
            UserStepTwo.shared.height_unit = "Inchs"
            buttonTitleWithColor(button: inchesBtn)
            buttonTitleWithoutColor(button: cmBtn)
        }
        switchHeightScale(scale:sender.titleLabel?.text)
    }
    @IBAction func backToLastScreen(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func next_action(_ sender: Any) {
        if  UserStepTwo.shared.height ?? 0 > 0
        {
            if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GenderIdentityScreen") as? GenderIdentityScreen {
                if let navigator = navigationController {
                    navigator.pushViewController(viewController, animated: true)
                }
            }
        }
        else
        {
            show_alert(title:ErrorMessage.emptyFields, message:"")
        }
    }
}

