//
//  YogaExpertiseScreen.swift
//  YogiFi
//
//  Created by Girish Nandagiri on 07/08/20.
//  Copyright © 2020 Girish Nandagiri. All rights reserved.
//

import UIKit
import Lottie

class YogaExpertiseScreen: UIViewController {
    
    @IBOutlet weak var infoLbl: UILabel!
    @IBOutlet weak var logoAnimation: AnimationView!
    @IBOutlet weak var beginnerBtn: UIButton!
    @IBOutlet weak var intermediateBtn: UIButton!
    @IBOutlet weak var expertBtn: UIButton!
    @IBOutlet weak var beginnerView: UIView!
    @IBOutlet weak var intermediateView: UIView!
    @IBOutlet weak var expertView: UIView!
    @IBOutlet weak var additionalTextLbl: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var beginnerLbl: UILabel!
    @IBOutlet weak var intermediateLbl: UILabel!
    @IBOutlet weak var expertLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        additionalTextLbl.font = UIFont.textRegular16
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        logoAnimation.setupAnimationView(numberCircles: 8)
    }
    
    
    @IBAction func selectExpertiseLevel(_ sender: UIButton) {
        
        if sender.tag == 10{
            //Beginner
            additionalTextLbl.text = "Awesome! \("\n") It's never too late to get started"
            selectedOption(view: beginnerView, button: beginnerBtn, label: beginnerLbl)
            unSelectedOptions(view: intermediateView, button: intermediateBtn, label: intermediateLbl)
            unSelectedOptions(view: expertView, button: expertBtn, label: expertLbl)
            //beginnerTempFunction()
            UserStepTwo.shared.expertise = "Beginner"
        }
        else if sender.tag == 20{
            //Intermediate
            additionalTextLbl.text = "Cool! \("\n") Let's Take you a notch higher"
            unSelectedOptions(view: beginnerView, button: beginnerBtn, label: beginnerLbl)
            selectedOption(view: intermediateView, button: intermediateBtn, label: intermediateLbl)
            unSelectedOptions(view: expertView, button: expertBtn, label: expertLbl)
            UserStepTwo.shared.expertise = "Intermediate"
        }
        else{
            //Expert
            additionalTextLbl.text = "Cool! \("\n") Let's Take you a notch higher"
            unSelectedOptions(view: beginnerView, button: beginnerBtn, label: beginnerLbl)
            unSelectedOptions(view: intermediateView, button: intermediateBtn, label: intermediateLbl)
            selectedOption(view: expertView, button: expertBtn, label: expertLbl)
            UserStepTwo.shared.expertise = "Expert"
        }
    }
    
    func selectedOption(view : UIView, button : UIButton, label : UILabel){
        infoLbl.isHidden = true
        nextBtn.backgroundColor = UIColor.tealish
        nextBtn.setTitleColor(.white, for:.normal)
        view.layer.cornerRadius = view.frame.size.height / 2
        view.layer.borderWidth = 2
        view.backgroundColor = .blackThree
        view.layer.borderColor = UIColor.tealish.cgColor
        button.isHidden = true
        label.font = UIFont.textItalicBold14
        label.textColor = UIColor.tealish
    }
    
    func unSelectedOptions(view : UIView, button : UIButton, label : UILabel){
        button.isHidden = false
        view.backgroundColor = .clear
        view.layer.borderColor = UIColor.clear.cgColor
        label.font = UIFont.textItalic14
        label.textColor = .white
    }
    
    @IBAction func backToLastScreen(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func next_action(_ sender: Any) {
        if  UserStepTwo.shared.expertise?.isEmpty ?? true
        {
            show_alert(title:ErrorMessage.selectOption, message:"")
        }
        else
        {
            if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SetGoalsScreen") as? SetGoalsScreen {
                if let navigator = navigationController {
                    navigator.pushViewController(viewController, animated: true)
                }
            }
        }
        
    }
    
}
