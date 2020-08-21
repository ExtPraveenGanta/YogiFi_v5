//
//  ParserHelper.swift
//  YogiFi
//
//  Created by NFCIndia on 18/08/20.
//  Copyright © 2020 GANTA PRAVEEN KUMAR. All rights reserved.
//

import Foundation
import SwiftyJSON



struct ParserHelper {
    
    /**
        Create JSON object
        */
       static func retriveJsonObj(with json:JSON?) -> [String:Any]? {
           
           let obj = json?.rawString()
           if let data = obj?.data(using: String.Encoding.utf8) {
               do {
                   let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any]
                   return json
               } catch {
                   return nil
               }
           }
           return nil
       }
       
       /**
        Create JSON array
        */
       
       static func retriveJsonArray(with json:JSON?) -> [[String:Any]]? {
           
           let obj = json?.rawString()
           if let data = obj?.data(using: String.Encoding.utf8) {
               do {
                   let jsonArray = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String:Any]]
                   return jsonArray
               } catch {
                   return nil
               }
           }
           return nil
       }
}
