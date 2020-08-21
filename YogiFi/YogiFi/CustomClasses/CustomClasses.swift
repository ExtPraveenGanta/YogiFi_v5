//
//  Button_Title.swift
//  YogiFi
//
//  Created by Kalyan Chakravarthi Pusuluri on 05/08/20.
//  Copyright © 2020 Kalyan Chakravarthi Pusuluri. All rights reserved.
//

import UIKit



class CustomClasses: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
            self.addTarget(self, action:#selector(handleRegister), for: .touchUpInside)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func handleRegister(){
       // self.navigationController?.popViewController(animated: true)
    }
}

class CustomRoundedButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        buttonProperties()
    }
    private func buttonProperties() {
        layer.cornerRadius = self.frame.size.height / 2
        layer.borderWidth = 2
        layer.backgroundColor = UIColor.blackThree.cgColor
        layer.borderColor = UIColor.warmGrey.cgColor
    }
}

class CustomButtonCornerRadius8: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        buttonProperties()
    }
    private func buttonProperties() {
        layer.cornerRadius = 8
    }
}

class CustomButtonCornerRadius5: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        buttonProperties()
    }
    private func buttonProperties() {
        layer.cornerRadius = 5
    }
}

import Foundation
import UIKit

@IBDesignable
class CardView: UIView {

    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.shadowRadius = newValue
            layer.masksToBounds = false
        }
    }

    @IBInspectable var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
            layer.shadowColor = UIColor.darkGray.cgColor
        }
    }

    @IBInspectable var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
            layer.shadowColor = UIColor.black.cgColor
            layer.masksToBounds = false
        }
    }

}
