//
//  RESTApiConst.swift
//  YogiFi
//
//  Created by NFCIndia on 18/08/20.
//  Copyright © 2020 GANTA PRAVEEN KUMAR. All rights reserved.
//

import Foundation

struct RESTApiConst {
    
    static let baserURL = "http://130.211.112.243/" //staging URL
    static let userRegistration = "v5/user_registration/signup"
    static let verifyUser = "v5/user_registration/verifyEmail"
    static let resendVerification = "v5/user_registration/resendVerifyEmail"
    static let profileStepOne = "v5/student_info/studentProfileStep1"
    static let profileStepTwo = "v5/student_info/studentProfileStep2"
    static let getGoals = "v4/student_info/getUserGoals"
    static let userSignIn = "v5/user_registration/signin"
    static let socialLogin = "v5/user_registration/GoogleFacebook"
    static let appleSignIn = "v5/user_registration/appleAuth"
}


