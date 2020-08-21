//
//  GenderIdentity+Extension.swift
//  YogiFi
//
//  Created by NFCIndia on 19/08/20.
//  Copyright © 2020 GANTA PRAVEEN KUMAR. All rights reserved.
//

import Foundation
import SwiftyJSON

extension GenderIdentityScreen:GenderIdentityScreenDelegate
{
    func handlePostStepTwoResponse(data: JSON?) {
        YFLoadingIndicator.hide(view:self.view)
        guard let response = data else {return}
        print(response)
        if response["code"].intValue == 200
        {
            pushToYogifiStatusScreen()
        }
        else
        {
            show_alert(title:response["message"].stringValue, message:"")
            
        }
    }
    
}

extension GenderIdentityScreen
{
    func pushToYogifiStatusScreen()
    {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "YogifiStatusScreen") as? YogifiStatusScreen {
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
}


