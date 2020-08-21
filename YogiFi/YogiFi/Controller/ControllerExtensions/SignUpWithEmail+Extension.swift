//
//  SignUpWithEmail+Extension.swift
//  YogiFi
//
//  Created by NFCIndia on 18/08/20.
//  Copyright © 2020 GANTA PRAVEEN KUMAR. All rights reserved.
//


//This is an exclusive class for maintaining all the extensions related to SignUpWithEmailScreen

import Foundation
import UIKit
import SwiftyJSON


extension SignUpWithEmailScreen
{
    //function for validation
    func  validate_email_pass(email:String?,password:String?) -> (valid:Bool, errorMessage:String)
    {
        if (!email!.isEmpty && !password!.isEmpty)
        {
            if email!.isValidEmail
            {
                return (true,"")
            }
            else
            {
                return (false,ErrorMessage.invalidEmail)
                
            }
        }
        else {
            return (false,ErrorMessage.emptyFields)
        }
    }
    
    
    
    func postRegister()
    {
        let getValidations = validate_email_pass(email:emailTF.text, password:createPasswordTF.text)
        guard getValidations.valid else {
            show_alert(title:getValidations.errorMessage, message:"")
            return
        }
        YFLoadingIndicator.show(view:self.view)
        signUpViewModel.postRegister(emailTF.text,createPasswordTF.text)
        
    }
    
    
    //method to navigate to verify code screen
    func pushToVerifyCode()
    {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "eMailVerificationScreen") as? eMailVerificationScreen {
            viewController.emailString = emailTF.text
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
    
    //method to help extracting Data
    func parseUserDetails(with data:JSON?) -> SignUpModel? {
        if let responseDic = ParserHelper.retriveJsonObj(with: data) {
            if let theJSONData = try? JSONSerialization.data(withJSONObject: responseDic, options: []) {
                let decoder = JSONDecoder()
                if let info = try? decoder.decode(SignUpModel.self, from: theJSONData) {
                    return info
                }
            }
        }
        return nil
    }
    
}

extension SignUpWithEmailScreen:SignUpWithEmailScreenDelegate
{
    func handleRegisterresponse(data:JSON?)
    {
        YFLoadingIndicator.hide(view:self.view)
        guard let response = data else {return}
        print(response)
        if response["code"].intValue == 200
        {
            if let model = parseUserDetails(with:response)
            { signUpModel = model }
            Constant.accessToken = response["token"].stringValue
            pushToVerifyCode()
        }
        else
        {
            self.show_alert(title:"", message:response["message"].stringValue)
        }
        
    }
}

extension SignUpWithEmailScreen:UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let userEnteredString = textField.text
        let newString = (userEnteredString! as NSString).replacingCharacters(in: range, with: string) as NSString
        if  newString != ""{
            if (emailTF.text?.count ?? 0 > 0) && (createPasswordTF.text?.count ?? 0 > 0)
            {
                nextBtn.backgroundColor = .tealish
                nextBtn.setTitleColor(.white, for:.normal)
            }
            else
            {
                nextBtn.backgroundColor = .white
                nextBtn.setTitleColor(.tealish, for:.normal)
            }
        } else {
            nextBtn.backgroundColor = .white
            nextBtn.setTitleColor(.tealish, for:.normal)
        }
        
        return true
    }
}
