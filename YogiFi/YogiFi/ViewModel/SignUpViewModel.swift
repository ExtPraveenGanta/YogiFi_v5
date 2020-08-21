//
//  SignUpViewModel.swift
//  YogiFi
//
//  Created by NFCIndia on 18/08/20.
//  Copyright © 2020 GANTA PRAVEEN KUMAR. All rights reserved.
//

import Foundation


protocol SignUpViewModelDelegate  {
    func postRegister(_ emailText:String?,_ passWordText:String?)
}

struct SignUpViewModel {
    
     let service =  RequestService()
     var signUpDelegate:SignUpWithEmailScreenDelegate?
        
    
    
     func postRegister(_ emailText:String?,_ passWordText:String?)
    {
        guard let email = emailText else {return}
        guard let password = passWordText else {return}
        let params = ["email":email,
                      "password":password,
                      "user_type":"student",
                      "fcm_token":"dasdasda",
                      "time_zone":"GMT+0530"]
        service.postData(urlString: RESTApiConst.baserURL + RESTApiConst.userRegistration, params:params,session:false) { (result) in
            self.signUpDelegate?.handleRegisterresponse(data:result)
        }
    }
    
}

