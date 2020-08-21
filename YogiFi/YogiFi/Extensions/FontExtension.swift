//
//  FontExtension.swift
//  YogiFi
//
//  Created by Kalyan Chakravarthi Pusuluri on 10/08/20.
//  Copyright © 2020 Kalyan Chakravarthi Pusuluri. All rights reserved.
//

import Foundation
import UIKit



enum FontBook: String {
    case regular = "NotoSans-Regular"
    case bold = "NotoSans-Bold"
    case italic = "NotoSans-Italic"
    case boldItalic = "NotoSans-BoldItalic"
}



extension UIFont {
    
    static func regular(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: FontBook.regular.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
    }
    static func bold(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: FontBook.bold.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
    }
    static func italic(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: FontBook.italic.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
    }
    static func boldItalic(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: FontBook.boldItalic.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    class var textBold16: UIFont {
        return UIFont.bold(ofSize: 16)
    }
    class var textRegular16: UIFont {
        return UIFont.regular(ofSize: 16)
    }
    class var textBold12: UIFont {
        return UIFont.bold(ofSize: 12)
    }
    class var textRegular12: UIFont {
        return UIFont.regular(ofSize: 12)
    }
    class var textBold14: UIFont {
        return UIFont.bold(ofSize: 14)
    }
    class var textBold15: UIFont {
        return UIFont.bold(ofSize: 15)
    }
    class var textItalic14: UIFont {
        return UIFont.italic(ofSize: 14)
    }
    class var textItalicBold16: UIFont {
        return UIFont.boldItalic(ofSize: 16)
    }
    class var textItalicBold14: UIFont {
        return UIFont.boldItalic(ofSize: 14)
    }
}
