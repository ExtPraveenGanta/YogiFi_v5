//
//  UserStepTwo.swift
//  YogiFi
//
//  Created by NFCIndia on 18/08/20.
//  Copyright © 2020 GANTA PRAVEEN KUMAR. All rights reserved.
//

import Foundation


class UserStepTwo{
    
    static let shared = UserStepTwo()
    var expertise: String?
    var goals : [String]?
    var student_dob : [String:Any]?
    var height : Int?
    var height_unit :String?
    var weight:Int?
    var weight_unit:String?
    var gender:String?
    var country:String?
    var city:String?
    var display_name:String?
    
    //Initializer access level change now
    private init(){
        self.weight_unit = "Lbs"
        self.height_unit = "Inchs"
    }
    
    
}
