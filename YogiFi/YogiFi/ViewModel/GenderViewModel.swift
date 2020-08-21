//
//  GenderViewModel.swift
//  YogiFi
//
//  Created by NFCIndia on 19/08/20.
//  Copyright © 2020 GANTA PRAVEEN KUMAR. All rights reserved.
//

import Foundation




protocol GenderViewModelDelegate  {
func postProfileStepTwo(userModel:UserStepTwo?)
}

struct GenderViewModel {
    
    let service =  RequestService()
    var genderIdentityScreenDelegate:GenderIdentityScreenDelegate?

    func postProfileStepTwo(userModel:UserStepTwo?)
    {
        
        guard let uModel = userModel else {return}
        let params = ["student_dob":uModel.student_dob!,
                      "height":uModel.height!,
                      "height_unit":uModel.height_unit!,
                      "weight":uModel.weight!,
                      "weight_unit":uModel.weight_unit!,
                      "gender":uModel.gender!,
                      "expertise":uModel.expertise!,
                      "country":"",
                      "city":"",
                      "goals":uModel.goals!,
                      "display_name":uModel.display_name ?? ""
            ] as [String : Any]
        print(params)
        service.postData(urlString: RESTApiConst.baserURL + RESTApiConst.profileStepTwo, params:params,session:true) { (result) in
            self.genderIdentityScreenDelegate?.handlePostStepTwoResponse(data:result)
        }
    }
    
}
