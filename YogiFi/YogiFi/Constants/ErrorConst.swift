//
//  ErrorConst.swift
//  YogiFi
//
//  Created by NFCIndia on 18/08/20.
//  Copyright © 2020 GANTA PRAVEEN KUMAR. All rights reserved.
//

import Foundation
import SwiftyJSON

enum ErrorCode:Int {
    case defaultErrorCode = 999, unotherized = 401, notFound = 404, internalException = 500, userExists = 409
}

struct ErrorMessage {
    static let timeOut = "Request timed out. Please try again"
    static let unotherized = "Enter valid credentials"
    static let exception = "Something went wrong. Please try again"
    static let notFound = "Something went wrong. Please try again"
    static let requestFailed = "Request failed. Please try again"
    static let userExists = "User already exists, please sign in"
    static let noInternet = "The Internet connection appears to be offline."
    static let wrongUrl = "Wrong url format"
    static let invalidEmail = "Invalid email"
    static let emptyFields = "Fields cannot be empty, Please enter the values"
    static let invalidCode = "Please enter valid code"
    static let selectOption = "Please select an option"
    
    let timeOutJsonObject = JSON(["code":ErrorCode.defaultErrorCode.rawValue,"message":ErrorMessage.timeOut])
    let unOtherizedJsonObject = JSON(["code":ErrorCode.defaultErrorCode.rawValue,"message":ErrorMessage.unotherized])
    let userExistsJsonObject = JSON(["code":ErrorCode.defaultErrorCode.rawValue,"message":ErrorMessage.userExists])
    let notFoundJsonObject = JSON(["code":ErrorCode.defaultErrorCode.rawValue,"message":ErrorMessage.notFound])
    let exceptionJsonObject = JSON(["code":ErrorCode.defaultErrorCode.rawValue,"message":ErrorMessage.exception])
    let faiedJsonObject = JSON(["code":ErrorCode.defaultErrorCode.rawValue,"message":ErrorMessage.requestFailed])
    let noInternetJsonObject = JSON(["code":ErrorCode.defaultErrorCode.rawValue,"message":ErrorMessage.noInternet])
     let wrongUrlJson = JSON(["code":ErrorCode.defaultErrorCode.rawValue,"message":ErrorMessage.wrongUrl])
    
}
