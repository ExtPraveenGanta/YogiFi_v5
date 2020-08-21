//
//  SWEDeatailsScreen+Extension.swift
//  YogiFi
//
//  Created by NFCIndia on 18/08/20.
//  Copyright © 2020 GANTA PRAVEEN KUMAR. All rights reserved.
//

import Foundation
import SwiftyJSON

extension SignUpWithEmailDeatailsScreen
{
    
    func pushToWelcomeScreen()
    {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WelcomeToYogiFiScreen") as? WelcomeToYogiFiScreen {
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
    
    func validateFirstName(name:String?) -> (valid:Bool, errorMessage:String)
    {
        if !name!.isEmpty
        {
            return (true,"")
        }
        else
        {
            return (false,ErrorMessage.emptyFields)
        }
    }
    //func for posting code
    func postStepOne()
    {
        let getValidations = validateFirstName(name:firstNameTF.text)
        guard getValidations.valid else {
            show_alert(title:getValidations.errorMessage, message:"")
            return
        }
        YFLoadingIndicator.show(view:self.view)
        signUpDetailsViewModel.postProfileStepOne(firstNameTF.text,lastNameTF.text)
    }
}

extension SignUpWithEmailDeatailsScreen:SWEDeatailsScreenDelegate
{
    func handleRequestResponse(data: JSON?) {
        YFLoadingIndicator.hide(view:self.view)
        guard let response = data else {return}
        if response["code"].intValue == 200
        {
            Constant.name = (firstNameTF.text ?? "") + " " + (lastNameTF.text ?? "")
            pushToWelcomeScreen()
        }
        else
        {
            self.show_alert(title:"", message:response["message"].stringValue)
        }
    }
    
}

extension SignUpWithEmailDeatailsScreen:UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == firstNameTF
        {
        let userEnteredString = textField.text
        let newString = (userEnteredString! as NSString).replacingCharacters(in: range, with: string) as NSString
        if  newString != ""{
            nextBtn.backgroundColor = .tealish
            nextBtn.setTitleColor(.white, for:.normal)
        } else {
            nextBtn.backgroundColor = .white
            nextBtn.setTitleColor(.tealish, for:.normal)
        }
        }
        return true
    }
}
