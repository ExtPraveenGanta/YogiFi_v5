//
//  CustomTableViewCells.swift
//  YogiFi
//
//  Created by Kalyan Chakravarthi Pusuluri on 10/08/20.
//  Copyright © 2020 Kalyan Chakravarthi Pusuluri. All rights reserved.
//

import UIKit

class CustomTableViewCells: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

class SetGoalsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var goalsBackgroundView: UIView!
    @IBOutlet weak var goalsTitlelbl: UILabel!
    @IBOutlet weak var goalsSelectedImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        goalsTitlelbl.font = .textBold15
        goalsBackgroundView.layer.shadowOffset = .zero
        goalsBackgroundView.layer.shadowOpacity = 3.6
        goalsBackgroundView.layer.shadowRadius = 6.0

    }
}

class YogifiStatusCell: UICollectionViewCell {
    @IBOutlet weak var topLbl: UILabel!
    @IBOutlet weak var bottomWhiteLbl: UILabel!
    @IBOutlet weak var bottomColorLbl: UILabel!
    @IBOutlet weak var buyBtn: UIButton!

    @IBOutlet weak var btnView: UIView!
    @IBOutlet weak var bgView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        btnView.clipsToBounds = true
        btnView.layer.cornerRadius = 10
        btnView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    
}
