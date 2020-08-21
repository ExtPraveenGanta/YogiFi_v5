//
//  GenderIdentityScreen.swift
//  YogiFi
//
//  Created by Girish Nandagiri on 06/08/20.
//  Copyright © 2020 Girish Nandagiri. All rights reserved.
//

import UIKit
import Lottie
import SwiftyJSON

protocol  GenderIdentityScreenDelegate {
    func handlePostStepTwoResponse(data:JSON?)
}


class GenderIdentityScreen: UIViewController {
    
    @IBOutlet weak var logoAnimation: AnimationView!
    @IBOutlet weak var maleBtn: UIButton!
    @IBOutlet weak var femaleBtn: UIButton!
    @IBOutlet weak var othersBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var infoLabel: UILabel!
    
    @IBOutlet weak var maleImg: UIImageView!
    @IBOutlet weak var femaleImage: UIImageView!
    @IBOutlet weak var otherImage: UIImageView!
    
    var genderViewModel = GenderViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        genderButtonsProperties()
        
        genderViewModel.genderIdentityScreenDelegate = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        logoAnimation.setupAnimationView(numberCircles: 7)
    }
    
    
    private func genderButtonsProperties() {
        buttonTextColorAndFont(button: maleBtn)
        buttonTextColorAndFont(button: femaleBtn)
        buttonTextColorAndFont(button: othersBtn)
        
        
        genderButtonLayerSadow(button: femaleBtn)
        genderButtonLayerSadow(button: maleBtn)
        genderButtonLayerSadow(button: othersBtn)
        
    }
    func genderButtonLayerSadow(button : UIButton) {
        button.layer.shadowOffset = .zero
        button.layer.shadowOpacity = 3.6
        button.layer.shadowRadius = 6.0
        //button.layer.shadowPath = UIBezierPath(rect: button.bounds).cgPath
        
    }
    func buttonTextColorAndFont(button : UIButton){
        button.titleLabel?.font = UIFont.textBold15
        button.setTitleColor(UIColor.pinkishGrey, for: .normal)
    }
    func genderButtonWithBortder(button : UIButton) {
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.tealish.cgColor
        button.setTitleColor(UIColor.tealish, for: .normal)
    }
    func genderButtonWithoutBorder(button : UIButton) {
        button.layer.borderColor = UIColor.clear.cgColor
        button.setTitleColor(UIColor.pinkishGrey, for: .normal)
    }
    
    @IBAction func selectGender(_ sender: UIButton) {
        if sender.tag == 11{
            //Male
            UserStepTwo.shared.gender = "Male"
            genderButtonWithBortder(button: maleBtn)
            genderButtonWithoutBorder(button: femaleBtn)
            genderButtonWithoutBorder(button: othersBtn)
            maleImg.isHidden = false
            femaleImage.isHidden = true
            otherImage.isHidden = true
        }
        else if sender.tag == 12{
            //Female
            UserStepTwo.shared.gender = "Female"
            genderButtonWithoutBorder(button: maleBtn)
            genderButtonWithBortder(button: femaleBtn)
            genderButtonWithoutBorder(button: othersBtn)
            maleImg.isHidden = true
            femaleImage.isHidden = false
            otherImage.isHidden = true
        }
        else{
            //Other
            UserStepTwo.shared.gender = "Other"
            genderButtonWithoutBorder(button: maleBtn)
            genderButtonWithoutBorder(button: femaleBtn)
            genderButtonWithBortder(button: othersBtn)
            maleImg.isHidden = true
            femaleImage.isHidden = true
            otherImage.isHidden = false
        }
        infoLabel.text = ""
        nextBtn.backgroundColor = .tealish
        nextBtn.setTitleColor(.white, for:.normal)
        
    }
    @IBAction func backToLastScreen(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func next_action(_ sender: Any) {
        if  UserStepTwo.shared.gender?.isEmpty ?? true
        {
          show_alert(title:ErrorMessage.selectOption, message:"")

        }
        else
        {
            YFLoadingIndicator.show(view:self.view)
            genderViewModel.postProfileStepTwo(userModel:UserStepTwo.shared)
        }
    }
}
