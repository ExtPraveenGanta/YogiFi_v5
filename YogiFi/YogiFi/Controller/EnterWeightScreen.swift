//
//  EnterWeightScreen.swift
//  YogiFi
//
//  Created by Girish Nandagiri on 06/08/20.
//  Copyright © 2020 Girish Nandagiri. All rights reserved.
//

import UIKit
import Lottie

class EnterWeightScreen: UIViewController {
    
    @IBOutlet weak var logoAnimation: AnimationView!
    @IBOutlet weak var enterWeight: UITextField!
    @IBOutlet weak var kgBtn: UIButton!
    @IBOutlet weak var lbsBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    var weightPicker = UIPickerView()
    var weightsArray = [Int]()
    var selectedRow = -1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font :  UIFont.textRegular16//UIFont(name: "Roboto-Bold", size: 17)! // Note the !
        ]
        enterWeight.attributedPlaceholder = NSAttributedString(string: "Enter Here", attributes:attributes)
        
        buttonTitleWithColor(button: lbsBtn)
        buttonTitleWithoutColor(button: kgBtn)
        
        setUpPicker()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        logoAnimation.setupAnimationView(numberCircles: 5)
    }
    
    
    func buttonTitleWithColor(button : UIButton) {
        button.titleLabel?.font = UIFont.textBold14
        button.setTitleColor(UIColor.tangerine, for: .normal)
    }
    func buttonTitleWithoutColor(button : UIButton) {
        button.titleLabel?.font = UIFont.textRegular12
        button.setTitleColor(UIColor.warmGrey, for: .normal)
    }
    
    @IBAction func weightInKgOrLbs(_ sender: UIButton) {
        if sender.titleLabel?.text == "Kgs" {
            UserStepTwo.shared.weight_unit = "Kgs"
            buttonTitleWithColor(button: kgBtn)
            buttonTitleWithoutColor(button: lbsBtn)
        }
        else{
            UserStepTwo.shared.weight_unit = "Lbs"
            buttonTitleWithColor(button: lbsBtn)
            buttonTitleWithoutColor(button: kgBtn)
        }
        switchWeightScale(scale:sender.titleLabel?.text)
    }
    
    @IBAction func backToLastScreen(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func next_action(_ sender: Any) {
        if  UserStepTwo.shared.weight ?? 0 > 0
        {
            if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EnterHeightScreen") as? EnterHeightScreen {
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
