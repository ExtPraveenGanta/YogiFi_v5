//
//  SignUpDetailsViewModel.swift
//  YogiFi
//
//  Created by NFCIndia on 18/08/20.
//  Copyright © 2020 GANTA PRAVEEN KUMAR. All rights reserved.
//

import Foundation


protocol SignUpDetailsViewModelDelegate {
    func postProfileStepOne(_ verification_code:String?)
}

struct SignUpDetailsViewModel {
    
    let service =  RequestService()
    var sWEDeatailsScreenDelegate:SWEDeatailsScreenDelegate?
    
    func postProfileStepOne(_ first_name:String?,_ last_name:String?)
    {
        guard let fName = first_name else {return}
        guard let lName = last_name else {return}
        let params = ["first_name":fName,"last_name":lName]
        service.postData(urlString: RESTApiConst.baserURL + RESTApiConst.profileStepOne, params:params,session:true) { (result) in
            self.sWEDeatailsScreenDelegate?.handleRequestResponse(data: result)
        }
    }
    
    
}
