//
//  EnterHeight+Extension.swift
//  YogiFi
//
//  Created by NFCIndia on 19/08/20.
//  Copyright © 2020 GANTA PRAVEEN KUMAR. All rights reserved.
//

import Foundation
import UIKit


extension EnterHeightScreen
{
    
    func setUpPicker() {
        
        for w in 36..<79
        {
            heightsArray.append(w)
        }
        
        heightPicker.dataSource = self
        heightPicker.delegate = self
              
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar .setItems([doneButton], animated: true)
        
        enterHeightTF.inputAccessoryView = toolbar
        enterHeightTF.inputView = heightPicker
    }
    
    @objc func donePressed(){
        if selectedRow >= 0
        {
        UserStepTwo.shared.height = heightsArray[selectedRow]
        }
        nextBtn.backgroundColor = .tealish
        nextBtn.setTitleColor(.white, for:.normal)
        self.view.endEditing(true)
    }
    
    func switchHeightScale(scale:String?)
    {
        heightsArray.removeAll()
        if scale == "Cms"
        {
            for h in 90..<199
            {
                heightsArray.append(h)
            }
        }
        else
        {
            for h in 36..<79
            {
                heightsArray.append(h)
            }
        }
        heightPicker.reloadAllComponents()
        if selectedRow >= 0
        {
        UserStepTwo.shared.weight = heightsArray[selectedRow]
        enterHeightTF.text = "\(String(describing: heightsArray[selectedRow]))"
        }
    }

}


extension EnterHeightScreen: UIPickerViewDataSource
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return heightsArray.count
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(String(describing: heightsArray[row])) \(UserStepTwo.shared.height_unit ?? "Inchs")"
    }
}

extension EnterHeightScreen: UIPickerViewDelegate
{
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
         selectedRow  = row
        enterHeightTF.text = "\(String(describing: heightsArray[row]))"
       
    }
}
