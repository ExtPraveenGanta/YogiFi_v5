//
//  eMailVerification+Extension.swift
//  YogiFi
//
//  Created by NFCIndia on 18/08/20.
//  Copyright © 2020 GANTA PRAVEEN KUMAR. All rights reserved.
//

import Foundation
import SwiftyJSON



extension eMailVerificationScreen
{
    
    //set
    func setUpOtpField()
    {
        self.otpTextFieldView.fieldsCount = 4
        self.otpTextFieldView.fieldBorderWidth = 2
        self.otpTextFieldView.defaultBorderColor = UIColor.pinkishGrey
        self.otpTextFieldView.filledBorderColor = UIColor.tealish
        self.otpTextFieldView.cursorColor = UIColor.white
        self.otpTextFieldView.displayType = .underlinedBottom
        self.otpTextFieldView.fieldSize = 50
        self.otpTextFieldView.separatorSpace = 8
        self.otpTextFieldView.shouldAllowIntermediateEditing = false
        self.otpTextFieldView.delegate = self
        self.otpTextFieldView.fieldFont = UIFont(name:Font.notoSans_Bold, size: 25)!
        self.otpTextFieldView.initializeUI()
    }
    
    
    //method to navigate to   screen
    func pushToSignUpWithEmailDeatailsScreen()
    {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignUpWithEmailDeatailsScreen") as? SignUpWithEmailDeatailsScreen {
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
    
    //func for validations
    func validCode(code:String?) -> (valid:Bool, errorMessage:String) {
        if !code!.isEmpty && code?.count == 4
        {
            return (true,"")
        }
        else
        {
            return (false,ErrorMessage.invalidCode)
        }
    }
    
    //func for posting code
    func postVerifyRegisterCode()
    {
        let getValidations = validCode(code:otpString)
        guard getValidations.valid else {
            show_alert(title:getValidations.errorMessage, message:"")
            return
        }
        YFLoadingIndicator.show(view:self.view)
        emailVerifyViewModel.postVerifyEmail(otpString)
    }
}

extension eMailVerificationScreen:eMailVerificationScreenDelegate
{
    
    func handleResponseForVerify(data:JSON?)
    {
        YFLoadingIndicator.hide(view:self.view)
        guard let response = data else {return}
        if response["code"].intValue == 200
        {
            pushToSignUpWithEmailDeatailsScreen()
        }
        else
        {
            self.show_alert(title:"", message:response["message"].stringValue)
        }
        
    }
    func handleResponseForResend(data:JSON?)
    {
        YFLoadingIndicator.hide(view:self.view)
        guard let response = data else {return}
        self.show_alert(title:response["message"].stringValue, message:"")
    }
}

extension eMailVerificationScreen:UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
  
}

extension eMailVerificationScreen: OTPFieldViewDelegate {
    func hasEnteredAllOTP(hasEnteredAll hasEntered: Bool) -> Bool {
        if hasEntered
        {
            nextBtn.backgroundColor = .tealish
            nextBtn.setTitleColor(.white, for:.normal)
        }
        else
        {
            nextBtn.backgroundColor = .white
            nextBtn.setTitleColor(.tealish, for:.normal)
        }
        
        return false
    }
    
    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool {
        return true
    }
    
    func enteredOTP(otp otpString: String) {
        self.otpString = otpString
    }
}
