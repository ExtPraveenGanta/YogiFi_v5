//
//  SetGoalsViewModel.swift
//  YogiFi
//
//  Created by NFCIndia on 18/08/20.
//  Copyright © 2020 GANTA PRAVEEN KUMAR. All rights reserved.
//

import Foundation


protocol SetGoalsViewModelDelegate  {
    func getGoals()
}

struct SetGoalsViewModel {
    
    let service =  RequestService()
    var setGoalsScreenDelegate:SetGoalsScreenDelegate?
        

     func getGoals()
    {
        let params = ["":""]
        service.getData(urlString: RESTApiConst.baserURL + RESTApiConst.getGoals, params:params,session:true) { (result) in
            self.setGoalsScreenDelegate?.handleGoalsResponse(data:result)
        }
    }
    
}
