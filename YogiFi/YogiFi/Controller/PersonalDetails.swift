//
//  PersonalDetails.swift
//  YogiFi
//
//  Created by Girish Nandagiri on 06/08/20.
//  Copyright © 2020 Girish Nandagiri. All rights reserved.
//

import UIKit
import Lottie

class PersonalDetails: UIViewController {
    
    @IBOutlet weak var logoAnimation: AnimationView!
    @IBOutlet weak var monthLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var yearLbl: UILabel!
    @IBOutlet weak var textField : UITextField!
    @IBOutlet weak var nextBtn: UIButton!
    
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        createDatePicker()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        logoAnimation.setupAnimationView(numberCircles: 4)
    }
    
    
    @IBAction func backToLastScreen(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func createDatePicker(){
        var components = DateComponents()
        components.year = -100
        let minDate = Calendar.current.date(byAdding: components, to: Date())

        components.year = -7
        let maxDate = Calendar.current.date(byAdding: components, to: Date())

        datePicker.minimumDate = minDate
        datePicker.maximumDate = maxDate
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar .setItems([doneButton], animated: true)
        
        textField.inputAccessoryView = toolbar
        textField.inputView = datePicker
        
        datePicker.datePickerMode = .date
        
    }
    
    @objc func donePressed(){
        
        
        nextBtn.backgroundColor = .tealish
        nextBtn.setTitleColor(.white, for:.normal)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let year: String = dateFormatter.string(from: self.datePicker.date)
        dateFormatter.dateFormat = "LLLL"
        let month: String = dateFormatter.string(from: self.datePicker.date)
        dateFormatter.dateFormat = "dd"
        let day: String = dateFormatter.string(from: self.datePicker.date)
        
        
        
        dateLbl.text = day
        yearLbl.text = year
        monthLbl.text = month
        
        let student_dob = [
            "year":year,
            "month":Calendar.current.component(.month, from:datePicker.date),
            "date":day] as [String : Any]
        UserStepTwo.shared.student_dob = student_dob
        self.view.endEditing(true)
        
    }
    
    
    
    @IBAction func next_action(_ sender: Any) {
     pushToEnterWeightScreen()
    }
    
    func pushToEnterWeightScreen()
    {
    if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EnterWeightScreen") as? EnterWeightScreen {
                   if let navigator = navigationController {
                       navigator.pushViewController(viewController, animated: true)
                   }
               }
    }
    
    
    @IBAction func skip_action(_ sender: Any) {
        pushToEnterWeightScreen()
    }
}

