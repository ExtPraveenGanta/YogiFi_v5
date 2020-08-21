//
//  Constants.swift
//  YogiFi
//
//  Created by NFCIndia on 18/08/20.
//  Copyright © 2020 GANTA PRAVEEN KUMAR. All rights reserved.
//

import Foundation
import UIKit

class Constant {
    
    static var accessToken:String? {
        set {
            if let value = newValue {
                return UserDefaults.standard.set(value, forKey: UserDefaultKeys.accessToken.rawValue)
            }
            return UserDefaults.standard.removeObject(forKey: UserDefaultKeys.accessToken.rawValue)
        }
        get {
            return UserDefaults.standard.string(forKey: UserDefaultKeys.accessToken.rawValue)
        }
    }
    static var name:String? {
        set {
            if let value = newValue {
                return UserDefaults.standard.set(value, forKey: UserDefaultKeys.email.rawValue)
            }
            return UserDefaults.standard.removeObject(forKey: UserDefaultKeys.email.rawValue)
        }
        get {
            return UserDefaults.standard.string(forKey: UserDefaultKeys.email.rawValue)
        }
    }
    
    static var appleID:String? {
          set {
              if let value = newValue {
                  return UserDefaults.standard.set(value, forKey: UserDefaultKeys.appleID.rawValue)
              }
              return UserDefaults.standard.removeObject(forKey: UserDefaultKeys.appleID.rawValue)
          }
          get {
              return UserDefaults.standard.string(forKey: UserDefaultKeys.appleID.rawValue)
          }
      }
}



//MARK:- UserDefaultKeys
enum UserDefaultKeys:String {
    case accessToken = "accessToken.user"
    case email = "name.user"
    case appleID = "appleID.user"
}


