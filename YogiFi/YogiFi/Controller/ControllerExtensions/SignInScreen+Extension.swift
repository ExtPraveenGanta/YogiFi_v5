//
//  SignInScreen+Extension.swift
//  YogiFi
//
//  Created by NFCIndia on 19/08/20.
//  Copyright © 2020 GANTA PRAVEEN KUMAR. All rights reserved.
//

import Foundation
import SwiftyJSON



extension SignInScreen:SignInScreenDelegate
{
    func handleSignInResponsse(data: JSON?) {
        YFLoadingIndicator.hide(view:self.view)
        guard let response = data else {return}
        print(response)
        if response["code"].intValue == 200
        {
            if let model = parseUserDetails(with:response)
            { signInModel = model }
            Constant.accessToken = response["token"].stringValue
            Constant.name = (signInModel?.user_data?.first_name ?? "") + " " + (signInModel?.user_data?.last_name ?? "")
            if signInModel?.user_data?.profile_status    ==   "-1"
            {
                pushToStepOne()
            }
            else if signInModel?.user_data?.profile_status == "0"
            {
                pushToStepTwo()
            }
            else if signInModel?.user_data?.profile_status == "1"
            {
                pushToYogifiStatusScreen()
            }
        }
        else
        {
            self.show_alert(title:"", message:response["message"].stringValue)
        }
    }
    
}


extension SignInScreen
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
    
    func postUserSignIn()
    {
        let getValidations = validate_email_pass(email:emailTF.text, password:createPasswordTF.text)
        guard getValidations.valid else {
            show_alert(title:getValidations.errorMessage, message:"")
            return
        }
        YFLoadingIndicator.show(view:self.view)
        signInViewModel.postUserSignIn(emailTF.text,createPasswordTF.text)
    }
    
    //method to help extracting Data
    func parseUserDetails(with data:JSON?) -> SignInModel? {
        if let responseDic = ParserHelper.retriveJsonObj(with: data) {
            if let theJSONData = try? JSONSerialization.data(withJSONObject: responseDic, options: []) {
                let decoder = JSONDecoder()
                do {
                    let info = try decoder.decode(SignInModel.self, from: theJSONData)
                    return info
                } catch {
                    print(error)
                }
            }
        }
        return nil
    }
    
    
    func pushToStepOne()  {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignUpWithEmailDeatailsScreen") as? SignUpWithEmailDeatailsScreen {
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
    
    func pushToStepTwo() {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WelcomeToYogiFiScreen") as? WelcomeToYogiFiScreen {
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
    func pushToYogifiStatusScreen()
    {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "YogifiStatusScreen") as? YogifiStatusScreen {
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
}



extension SignInScreen:UITextFieldDelegate
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



