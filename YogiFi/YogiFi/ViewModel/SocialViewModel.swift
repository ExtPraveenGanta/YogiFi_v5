//
//  SocialViewModel.swift
//  YogiFi
//
//  Created by NFCIndia on 20/08/20.
//  Copyright © 2020 GANTA PRAVEEN KUMAR. All rights reserved.
//

import Foundation

protocol SocialViewModelDelegate  {
    func postFbLogin(_ emailText:String?,_ firstName:String?,_ lastName:String?,_ accountType:SocialAccountType,_ loginType:LoginType)
    func postSocialLogin(_ emailText:String?,_ firstName:String?,_ lastName:String?,_ accountType:SocialAccountType,_ loginType:LoginType)
    func postGmailLogin(_ emailText:String?,_ firstName:String?,_ lastName:String?,_ accountType:SocialAccountType,_ loginType:LoginType)
    func postAppleIDLogin(_ emailText:String?,_ firstName:String?,_ lastName:String?,_ accountID:String?,_ loginType:LoginType,_ auth:Bool)
}


enum SocialAccountType {
    case facebook
    case google
    case apple
}

enum LoginType {
    case signIn
    case signUp
}


struct SocialViewModel {
    
    let service =  RequestService()
    var signUpDelegate:SignUpOptionsScreenDelegate?
    var signInDelegate:SignInOptionsScreenDelegate?
    var signUpScreenDelegate:SignUpScreenDelegate?
    
    func postFbLogin(_ emailText:String?,_ firstName:String?,_ lastName:String?,_ accountType:SocialAccountType,_ loginType:LoginType)
    {
        postSocialLogin(emailText,firstName,lastName,.facebook,loginType)
        
    }
    
    func postGmailLogin(_ emailText:String?,_ firstName:String?,_ lastName:String?,_ accountType:SocialAccountType,_ loginType:LoginType)
    {
        postSocialLogin(emailText,firstName,lastName,.google,loginType)
    }
    
    
    func postSocialLogin(_ emailText:String?,_ firstName:String?,_ lastName:String?,_ accountType:SocialAccountType,_ loginType:LoginType)
    {
        guard let email = emailText else {return}
        guard let firstName = firstName else {return}
        guard let lastName = lastName else {return}
        
        var socialAccountType:String = ""
        switch accountType {
        case .facebook:
            socialAccountType = "facebook_reg"
        case .google:
            socialAccountType = "google_reg"
        case .apple:
            socialAccountType = "apple_reg"
        }
        
        let params = ["email": email, "first_name":firstName, "googlefacebook_id":socialAccountType, "user_type": "student", "fcm_token" : "nngnngng","last_name":lastName]
        service.postData(urlString: RESTApiConst.baserURL + RESTApiConst.socialLogin, params:params,session:false) { (result) in
            switch loginType
            {
            case .signIn :
                self.signInDelegate?.handleSocialresponse(data:result)
            case .signUp :
                self.signUpDelegate?.handleSocialresponse(data:result)
            }
        }
    }
    
    func postAppleIDLogin(_ emailText:String?,_ firstName:String?,_ lastName:String?,_ accountID:String?,_ loginType:LoginType,_ auth:Bool)
    {
        
        var params = [String:Any]()
        if auth
        {
            guard let accountID = accountID else {return}
            params = ["apple_id": accountID , "user_type": "student", "fcm_token" : "ibkjkj"]
        }
        else
        {
        guard let email = emailText else {return}
        guard let firstName = firstName else {return}
        guard let lastName = lastName else {return}
        guard let accountID = accountID else {return}
        params = ["email": email, "first_name":firstName,"last_name":lastName, "apple_id": accountID , "user_type": "student", "fcm_token" : "hffff"]
        }
        print("***Log Apple request params",params)
        service.postData(urlString: RESTApiConst.baserURL + RESTApiConst.appleSignIn, params:params,session:false) { (result) in
            switch loginType
            {
            case .signIn :
                self.signInDelegate?.handleSocialresponse(data:result)
            case .signUp :
                self.signUpScreenDelegate?.handleSocialresponse(data:result)
            }
        }
    }
    
    
    
}
