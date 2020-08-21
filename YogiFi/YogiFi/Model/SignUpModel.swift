//
//  SignUpModel.swift
//  YogiFi
//
//  Created by NFCIndia on 18/08/20.
//  Copyright © 2020 GANTA PRAVEEN KUMAR. All rights reserved.
//

import Foundation
//
//{
//  "data_user" : {
//    "is_verified" : 0,
//    "display_name" : "",
//    "user_type" : "student",
//    "time_zone" : "GMT+0530",
//    "email" : "praveen@wellnesys.com",
//    "fcm_token" : "dasdasda",
//    "profile_status" : -1
//  },
//  "token" : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1ZjNiZWYyYjc1NmYwZDAwMTcwYTQwN2YiLCJhY2Nlc3MiOiJhdXRoIiwiaWF0IjoxNTk3NzYzMzcxfQ.J_jsbd2uO9suHzd5NrKrNCfBHPFSdFJsiQwAEIuutdw",
//  "message" : "New user created",
//  "code" : 200
//}



struct SignUpModel : Codable {
    var data_user:UserData?
    var token:String?
    var message:String?
    var code:Int?
}

struct UserData : Codable {
    var is_verified : Int?
    var display_name : String?
    var user_type : String?
    var time_zone : String?
    var email :  String?
    var fcm_token : String?
    var profile_status : String?
}
