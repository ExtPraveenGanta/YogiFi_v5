//
//  SetGoalsScreen.swift
//  YogiFi
//
//  Created by Girish Nandagiri on 10/08/20.
//  Copyright © 2020 Girish Nandagiri. All rights reserved.
//

import UIKit
import Lottie
import SwiftyJSON


protocol SetGoalsScreenDelegate {
    func handleGoalsResponse(data:JSON?)
}


class SetGoalsScreen: UIViewController {
    
    @IBOutlet weak var logoAnimation: AnimationView!
    @IBOutlet weak var setGoalsTableView: UITableView!
     @IBOutlet weak var nextBtn: UIButton!
    var selectedGoals : [String] = []

    
    var setGoalsViewModel = SetGoalsViewModel()
    var goalsModel:GoalsModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setGoalsViewModel.setGoalsScreenDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        logoAnimation.setupAnimationView(numberCircles: 9)
        YFLoadingIndicator.show(view: self.view)
        setGoalsViewModel.getGoals()
    }
    
    
    
    @IBAction func backToLastScreen(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func next_action(_ sender: Any) {
        if selectedGoals.count >= 3
        {
        UserStepTwo.shared.goals = selectedGoals
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DisplayNameScreen") as? DisplayNameScreen {
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
        }
        else
        {
            show_alert(title:"", message:"Goals \(selectedGoals.count)/3 selected, Please select 3 goals to get started")
        }
    }
    
    
}
