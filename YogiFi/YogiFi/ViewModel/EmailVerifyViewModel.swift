//
//  EmailVerifyViewModel.swift
//  YogiFi
//
//  Created by NFCIndia on 18/08/20.
//  Copyright © 2020 GANTA PRAVEEN KUMAR. All rights reserved.
//

import Foundation

protocol EmailVerifyViewModelDelegate {
    
    func postVerifyEmail(_ verification_code:String?)
    func postResendCode()
}

struct EmailVerifyViewModel {
    
    let service =  RequestService()
    var emailDelegate:eMailVerificationScreenDelegate?
    
    func postVerifyEmail(_ verification_code:String?)
    {
        guard let vCode = verification_code else {return}
        let params = ["verification_code":vCode]
        service.postData(urlString: RESTApiConst.baserURL + RESTApiConst.verifyUser, params:params,session:true) { (result) in
            self.emailDelegate?.handleResponseForVerify(data:result)
        }
    }
    
    
    func postResendCode()  {
        let params = ["":""]
        service.postData(urlString: RESTApiConst.baserURL + RESTApiConst.resendVerification, params:params,session:true) { (result) in
            self.emailDelegate?.handleResponseForResend(data:result)
        }
    }
    
}
