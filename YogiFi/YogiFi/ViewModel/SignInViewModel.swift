//
//  SignInViewModel.swift
//  YogiFi
//
//  Created by NFCIndia on 19/08/20.
//  Copyright © 2020 GANTA PRAVEEN KUMAR. All rights reserved.
//

import Foundation


protocol SignInViewModelDelegate  {
    func postUserSignIn(_ emailText:String?,_ passWordText:String?)
}

struct SignInViewModel {
    
    let service =  RequestService()
    var signInScreenDelegate:SignInScreenDelegate?
    
     func postUserSignIn(_ emailText:String?,_ passWordText:String?)
    {
        guard let email = emailText else {return}
        guard let password = passWordText else {return}
        let params = ["email":email,
                      "password":password,
                      "user_type":"student"]
        service.postData(urlString: RESTApiConst.baserURL + RESTApiConst.userSignIn, params:params,session:false) { (result) in
            self.signInScreenDelegate?.handleSignInResponsse(data: result)
        }
    }
    
}
