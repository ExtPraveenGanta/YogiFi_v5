//
//  UIView+Extension.swift
//  YogiFi
//
//  Created by Kalyan Chakravarthi Pusuluri on 05/08/20.
//  Copyright © 2020 Kalyan Chakravarthi Pusuluri. All rights reserved.
//

import Foundation
import UIKit
import Lottie

extension UITextField {
    func textField()  {
        //self.borderStyle = .roundedRect
        self.layer.borderWidth = 2
        self.addPadding(.left(24.0))
        self.layer.cornerRadius = 8
        self.backgroundColor = .clear
        self.layer.borderColor = UIColor.greyishBrown.cgColor
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor.warmGrey])
    }
}

// Logo Animations
extension AnimationView{
    func setupAnimationView(numberCircles : CGFloat){
        let lottieViewAnimation = numberCircles * 65
        self.animationSpeed = 5.0
        self.play(fromFrame: 0, toFrame: lottieViewAnimation, loopMode: .playOnce)
    }
}

extension UITextField {

    enum PaddingSide {
        case left(CGFloat)
        case right(CGFloat)
        case both(CGFloat)
    }

    func addPadding(_ padding: PaddingSide) {

        self.leftViewMode = .always
        self.layer.masksToBounds = true


        switch padding {

        case .left(let spacing):
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            self.leftView = paddingView
            self.rightViewMode = .always

        case .right(let spacing):
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            self.rightView = paddingView
            self.rightViewMode = .always

        case .both(let spacing):
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            // left
            self.leftView = paddingView
            self.leftViewMode = .always
            // right
            self.rightView = paddingView
            self.rightViewMode = .always
        }
    }
}




extension UILabel {
    func underlineMyText(range1:String, range2:String) {
        if let textString = self.text {

            let str = NSString(string: textString)
            let firstRange = str.range(of: range1)
            let secRange = str.range(of: range2)
            let color = UIColor.tealish
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttributes([NSAttributedString.Key.foregroundColor : color, NSAttributedString.Key.font : UIFont.init(name: "NotoSans-Regular", size: 12)!,
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue as Any],range: firstRange)
            
            attributedString.addAttributes([NSAttributedString.Key.foregroundColor : color, NSAttributedString.Key.font : UIFont.init(name: "NotoSans-Regular", size: 12)!,
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue as Any],range: secRange)
            
            attributedText = attributedString
        }
    }
}

extension UIColor {
    class var scarlet: UIColor {
        return UIColor(red: 179.0 / 255.0, green: 0.0, blue: 27.0 / 255.0, alpha: 1.0)
    }
    class var tealish: UIColor {
        return UIColor(red: 35.0 / 255.0, green: 164.0 / 255.0, blue: 159.0 / 255.0, alpha: 1.0)
    }
    class var greyishBrown: UIColor {
        return UIColor(white: 69.0 / 255.0, alpha: 1.0)
    }
    class var white: UIColor {
        return UIColor(white: 238.0 / 255.0, alpha: 1.0)
    }
    class var blackTwo: UIColor {
        return UIColor(white: 6.0 / 255.0, alpha: 1.0)
    }
    class var warmGrey: UIColor {
        return UIColor(white: 112.0 / 255.0, alpha: 1.0)
    }
    class var blackThree: UIColor {
        return UIColor(white: 13.0 / 255.0, alpha: 1.0)
    }
    class var blackFour: UIColor {
        return UIColor(white: 19.0 / 255.0, alpha: 1.0)
    }
    class var pinkishGrey: UIColor {
        return UIColor(white: 187.0 / 255.0, alpha: 1.0)
    }
    class var whiteTwo: UIColor {
        return UIColor(white: 1.0, alpha: 1.0)
    }
    class var black75: UIColor {
        return UIColor(white: 0.0, alpha: 0.75)
    }
    class var black70: UIColor {
        return UIColor(white: 0.0, alpha: 0.7)
    }
    class var tealish51: UIColor {
        return UIColor(red: 35.0 / 255.0, green: 164.0 / 255.0, blue: 159.0 / 255.0, alpha: 0.51)
    }
    class var cherryRed: UIColor {
        return UIColor(red: 1.0, green: 5.0 / 255.0, blue: 42.0 / 255.0, alpha: 1.0)
    }
    class var black: UIColor {
        return UIColor(white: 34.0 / 255.0, alpha: 1.0)
    }
    class var blackFive: UIColor {
        return UIColor(white: 0.0, alpha: 1.0)
    }
    class var tangerine: UIColor {
        return UIColor(red: 241.0 / 255.0, green: 143.0 / 255.0, blue: 1.0 / 255.0, alpha: 1.0)
    }
    class var black75Two: UIColor {
        return UIColor(white: 30.0 / 255.0, alpha: 0.75)
    }
    class var steel: UIColor {
        return UIColor(red: 142.0 / 255.0, green: 142.0 / 255.0, blue: 147.0 / 255.0, alpha: 1.0)
    }
    class var black52: UIColor {
        return UIColor(white: 0.0, alpha: 0.52)
    }
    class var darkGreenBlue: UIColor {
        return UIColor(red: 19.0 / 255.0, green: 89.0 / 255.0, blue: 87.0 / 255.0, alpha: 1.0)
    }
    class var azure: UIColor {
        return UIColor(red: 0.01, green: 0.61, blue: 0.89, alpha: 1.00)
    }
    class var aqua: UIColor {
        return UIColor(red: 0.07, green: 0.91, blue: 0.88, alpha: 1.00)
    }
    
}

//extension UIFont {
//    class var textBold16: UIFont {
//        return UIFont(name: "NotoSans-Bold", size: 16.0)!
//    }
//    class var textRegular16: UIFont {
//        return UIFont(name: "NotoSans-Regular", size: 16.0)!
//    }
//    class var textBold12: UIFont {
//        return UIFont(name: "NotoSans-Bold", size: 12.0)!
//    }
//    class var textRegular12: UIFont {
//        return UIFont(name: "NotoSans-Regular", size: 12.0)!
//    }
//    class var textBold14: UIFont {
//        return UIFont(name: "NotoSans-Bold", size: 14.0)!
//    }
//    class var textBold15: UIFont {
//        return UIFont(name: "NotoSans-Bold", size: 15.0)!
//    }
//    class var textItalic14: UIFont {
//        return UIFont(name: "NotoSans-Italic", size: 14.0)!
//    }
//    class var textItalicBold16: UIFont {
//        return UIFont(name: "NotoSans-BoldItalic", size: 16.0)!
//    }
//}


extension UIView {
    func applyGradient() {
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.locations = [0, 1]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        gradient.colors = [
            UIColor.darkGreenBlue.cgColor,
            UIColor.blackThree.cgColor
        ]
        layer.insertSublayer(gradient, at: 0)
    }
}

