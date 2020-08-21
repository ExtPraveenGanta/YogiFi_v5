//
//  RequestService.swift
//  YogiFi
//
//  Created by NFCIndia on 18/08/20.
//  Copyright © 2020 GANTA PRAVEEN KUMAR. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


final class RequestService
{
    
    let acceptKey = "Accept"
    let value = "application/json"
    let formData = "multipart/form-data"
    let contentKey = "Content-Type"
    let authTokenKey = "x_auth"
    
    let errorMessage = ErrorMessage()
    
    func postData(urlString: String,params:[String:Any],session:Bool = false, completion: @escaping (JSON?) -> Void) {
        
        guard let url = URL(string: urlString) else {
            completion(errorMessage.wrongUrlJson)
            return
        }
        
        let jsonData = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        
        var request = RequestFactory.request(method: .POST, url: url)
        request.setValue(value, forHTTPHeaderField:contentKey)
        request.setValue(value, forHTTPHeaderField:acceptKey)
        if session
        {
            guard let token = Constant.accessToken else {return}
            print(token)
            request.setValue(token, forHTTPHeaderField:authTokenKey)
        }
        request.httpBody = jsonData
        
        if let reachability = Reachability(), !reachability.isReachable {
            request.cachePolicy = .returnCacheDataDontLoad
            completion(self.errorMessage.noInternetJsonObject)
            return
        }
        
        AF.request(request).responseJSON { (response) in
            switch response.response?.statusCode {
            case ErrorCode.unotherized.rawValue :
                completion(self.errorMessage.unOtherizedJsonObject)
            case ErrorCode.internalException.rawValue:
                completion(self.errorMessage.exceptionJsonObject)
            case ErrorCode.notFound.rawValue:
                completion(self.errorMessage.notFoundJsonObject)
            case ErrorCode.userExists.rawValue:
                completion(self.errorMessage.notFoundJsonObject)
            default:
                switch response.result
                {
                case .success(let value):
                    let json = JSON(value)
                    completion(json)
                case .failure(let error):
                    if error._code == NSURLErrorTimedOut {
                        completion(self.errorMessage.timeOutJsonObject)
                    } else {
                        completion(self.errorMessage.faiedJsonObject)
                    }
                }
            }
        }
        
    }
    
    
    
    
    func getData(urlString: String,params:[String:Any],session:Bool = false, completion: @escaping (JSON?) -> Void) {
          
          guard let url = URL(string: urlString) else {
              completion(errorMessage.wrongUrlJson)
              return
          }
          
          
          var request = RequestFactory.request(method: .GET, url: url)
//          request.setValue(value, forHTTPHeaderField:contentKey)
//          request.setValue(value, forHTTPHeaderField:acceptKey)
          if session
          {
              guard let token = Constant.accessToken else {return}
              request.setValue(token, forHTTPHeaderField:authTokenKey)
            print(token)
          }
          //request.httpBody = jsonData
          
          if let reachability = Reachability(), !reachability.isReachable {
              request.cachePolicy = .returnCacheDataDontLoad
              completion(self.errorMessage.noInternetJsonObject)
              return
          }
          print(url)
          AF.request(request).responseJSON { (response) in
              switch response.response?.statusCode {
              case ErrorCode.unotherized.rawValue :
                  completion(self.errorMessage.unOtherizedJsonObject)
              case ErrorCode.internalException.rawValue:
                  completion(self.errorMessage.exceptionJsonObject)
              case ErrorCode.notFound.rawValue:
                  completion(self.errorMessage.notFoundJsonObject)
              case ErrorCode.userExists.rawValue:
                  completion(self.errorMessage.notFoundJsonObject)
              default:
                  switch response.result
                  {
                  case .success(let value):
                      let json = JSON(value)
                      completion(json)
                  case .failure(let error):
                      if error._code == NSURLErrorTimedOut {
                          completion(self.errorMessage.timeOutJsonObject)
                      } else {
                          completion(self.errorMessage.faiedJsonObject)
                      }
                  }
              }
          }
          
      }
      
    
}





