//
//  Font.swift
//  YogiFi
//
//  Created by NFCIndia on 20/08/20.
//  Copyright © 2020 GANTA PRAVEEN KUMAR. All rights reserved.
//

import Foundation
import  UIKit


//MARK:- Font
struct Font {
    
    static let poppins_regular = "Poppins-Regular"
    static let poppins_medium = "Poppins-Medium"
    static let poppins_light = "Poppins-Light"
    static let poppins_semibold = "Poppins-SemiBold"
    static let poppins_bold = "Poppins-Bold"
    static let largeFontSize:CGFloat = 20.0
    
    static let notoSans = "NotoSans"
    static let notoSans_Bold = "NotoSans-Bold"
    static let notoSans_BoldItalic = "NotoSans-BoldItalic"
    static let notoSans_Italic = "NotoSans-Italic"
    static let notoSans_Regular = "NotoSans-Regular"
    static let notoSansKR_Black = "NotoSansKR-Black"
    static let notoSansKR_Bold = "NotoSansKR-Bold"
    static let notoSansKR_Light = "NotoSansKR-Light"
    static let notoSansKR_Medium = "NotoSansKR-Medium"
    static let notoSansKR_Regular = "NotoSansKR-Regular"
    static let notoSansKR_Thin = "NotoSansKR-Thin"
    
    
    /**
     Set scaled font based on user selection
     */
    static func getScaledFont(forFont name: String, textStyle: UIFont.TextStyle) -> UIFont {
        let userFont =  UIFontDescriptor.preferredFontDescriptor(withTextStyle: textStyle)
        let pointSize = userFont.pointSize
        
        guard let customFont = UIFont(name: name, size: pointSize) else {
            let systemFont = UIFont.systemFont(ofSize: pointSize)
            return UIFontMetrics.default.scaledFont(for: systemFont)
        }
        return UIFontMetrics.default.scaledFont(for: customFont)
        
//        if pointSize <= largeFontSize {
//
//        } else {
//            return UIFont(name: name, size: 15) ?? UIFont.systemFont(ofSize: 15)
//        }
    }
    
    /**
     Set scaled font for  titles
     */
    static func getScaledFontForTitle(forFont name: String, textStyle: UIFont.TextStyle) -> UIFont {
        let userFont =  UIFontDescriptor.preferredFontDescriptor(withTextStyle: textStyle)
        let pointSize = userFont.pointSize
        
        guard let customFont = UIFont(name: name, size: pointSize) else {
            let systemFont = UIFont.systemFont(ofSize: pointSize)
            return UIFontMetrics.default.scaledFont(for: systemFont)
        }
        return UIFontMetrics.default.scaledFont(for: customFont)
    }
}

