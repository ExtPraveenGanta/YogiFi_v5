//
//  SetGoals+Extension.swift
//  YogiFi
//
//  Created by NFCIndia on 19/08/20.
//  Copyright © 2020 GANTA PRAVEEN KUMAR. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON


extension SetGoalsScreen:UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goalsModel?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellReuseIdentifier = "cell"
        let cell : SetGoalsTableViewCell = self.setGoalsTableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! SetGoalsTableViewCell
        
        cell.goalsBackgroundView.backgroundColor = .blackTwo
        cell.goalsBackgroundView.layer.borderColor = UIColor.clear.cgColor
        cell.goalsTitlelbl.textColor = .pinkishGrey
        cell.goalsSelectedImage.image = UIImage(named: "CirclularCheckboxInactive")
        
        
        cell.goalsTitlelbl.text = goalsModel?.data?[indexPath.row].name
        if selectedGoals .contains(cell.goalsTitlelbl.text!)  {
            cell.goalsBackgroundView.layer.borderWidth = 1
            cell.goalsBackgroundView.layer.borderColor = UIColor.tealish.cgColor
            cell.goalsTitlelbl.textColor = .tealish
            cell.goalsSelectedImage.image = UIImage(named: "CirclularCheckboxActive")
        }
        
        
        return cell
    }
    
}

extension SetGoalsScreen:UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let currentCell = tableView.cellForRow(at: indexPath) as! SetGoalsTableViewCell
        
        if selectedGoals .contains(currentCell.goalsTitlelbl.text!)  {
            selectedGoals.removeAll(where: { $0 == currentCell.goalsTitlelbl.text })
            currentCell.goalsBackgroundView.layer.borderColor = UIColor.clear.cgColor
            currentCell.goalsTitlelbl.textColor = .pinkishGrey
            currentCell.goalsSelectedImage.image = UIImage(named: "CirclularCheckboxInactive")
        }
        else{
            if selectedGoals.count < 3
            {
                currentCell.goalsSelectedImage.image = UIImage(named: "CirclularCheckboxActive")
                currentCell.goalsBackgroundView.layer.borderWidth = 1
                currentCell.goalsBackgroundView.layer.borderColor = UIColor.tealish.cgColor
                currentCell.goalsTitlelbl.textColor = .tealish
                selectedGoals.append(currentCell.goalsTitlelbl.text!)
            }
        }
        if selectedGoals.count == 3
        {
            nextBtn.backgroundColor = .tealish
            nextBtn.setTitleColor(.white, for:.normal)
        }
        else
        {
            nextBtn.backgroundColor = .white
            nextBtn.setTitleColor(.tealish, for:.normal)
        }
       
    }
}


extension SetGoalsScreen:UIScrollViewDelegate
{

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
      DispatchQueue.main.async() {
            scrollView.scrollIndicators.vertical?.backgroundColor = UIColor.tealish
        }
        self.setGoalsTableView.flashScrollIndicators()
    }
}


extension SetGoalsScreen:SetGoalsScreenDelegate
{
    func handleGoalsResponse(data: JSON?) {
        YFLoadingIndicator.hide(view:self.view)
        guard let response = data else {return}
        print(response)
        if response["status"].intValue == 200
        {
            if let model = parseGoalsData(with:response)
            { goalsModel = model }
            setGoalsTableView.reloadData()
        }
        else
        {
            self.show_alert(title:"", message:response["message"].stringValue)
        }
    }
    
}


extension SetGoalsScreen
{
    //method to help extracting Data
    func parseGoalsData(with data:JSON?) -> GoalsModel? {
        if let responseDic = ParserHelper.retriveJsonObj(with: data) {
            if let theJSONData = try? JSONSerialization.data(withJSONObject: responseDic, options: []) {
                let decoder = JSONDecoder()
                if let info = try? decoder.decode(GoalsModel.self, from: theJSONData) {
                    return info
                }
            }
        }
        return nil
    }
}
