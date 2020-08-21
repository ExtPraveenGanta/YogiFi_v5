//
//  EnterWeight+Extension.swift
//  YogiFi
//
//  Created by NFCIndia on 19/08/20.
//  Copyright © 2020 GANTA PRAVEEN KUMAR. All rights reserved.
//

import Foundation
import UIKit


extension EnterWeightScreen
{
    
    func setUpPicker() {
        
        for w in 66..<309
        {
            weightsArray.append(w)
        }
        
        weightPicker.dataSource = self
        weightPicker.delegate = self
              
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar .setItems([doneButton], animated: true)
        
        enterWeight.inputAccessoryView = toolbar
        enterWeight.inputView = weightPicker
    }
    
    @objc func donePressed(){
        if selectedRow >= 0
        {
        UserStepTwo.shared.weight = weightsArray[selectedRow]
        }
        nextBtn.backgroundColor = .tealish
        nextBtn.setTitleColor(.white, for:.normal)
        self.view.endEditing(true)
    }
    
    func switchWeightScale(scale:String?)
    {
        weightsArray.removeAll()
        if scale == "Kgs"
        {
            for w in 30..<141
            {
                weightsArray.append(w)
            }
        }
        else
        {
            for w in 66..<309
            {
                weightsArray.append(w)
            }
        }
        weightPicker.reloadAllComponents()
        if selectedRow >= 0
        {
        UserStepTwo.shared.weight = weightsArray[selectedRow]
        enterWeight.text = "\(String(describing: weightsArray[selectedRow]))"
        }
    }
    
}


extension EnterWeightScreen: UIPickerViewDataSource
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return weightsArray.count
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(String(describing: weightsArray[row])) \(UserStepTwo.shared.weight_unit ?? "Lbs")"
    }
}

extension EnterWeightScreen: UIPickerViewDelegate
{
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRow  = row
        enterWeight.text = "\(String(describing: weightsArray[row]))"
       
    }
}
