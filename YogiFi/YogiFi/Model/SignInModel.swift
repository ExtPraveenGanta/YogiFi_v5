//
//  SignInModel.swift
//  YogiFi
//
//  Created by NFCIndia on 19/08/20.
//  Copyright © 2020 GANTA PRAVEEN KUMAR. All rights reserved.
//

import Foundation

struct SignInModel : Codable {
    var user_data:User?
    var token:String?
    var message:String?
    var code:Int?
}



struct User : Codable {
    var is_verified : Int?
    var display_name : String?
    var user_type : String?
    var time_zone : String?
    var email :  String?
    var profile_status : String?
    var first_name:String?
    var last_name:String?
}



struct SocialLoginModel:Codable {
    var user:SocialUser?
    var token:String?
    var message:String?
    var code:Int?
    var first_name:String?
    var last_name:String?
}


struct SocialUser : Codable {
    var is_verified : Int?
    var display_name : String?
    var user_type : String?
    var time_zone : String?
    var email :  String?
    var profile_status : Int?
    var _id : String?
}
