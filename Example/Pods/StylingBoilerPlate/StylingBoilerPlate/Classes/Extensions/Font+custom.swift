//
//  Font+custom.swift
//  71stStreet
//
//  Created by Pantera Engineering on 21/11/2016.
//  Copyright © 2016 Incubasys IT Solutions. All rights reserved.
//

import Foundation
import UIKit

public enum Font: String {
    case RubikRegular = "Rubik-Regular"
    case RubikMedium = "Rubik-Medium"
    case RubikBold = "Rubik-Bold"
    
    case GeezaPro = "GeezaPro"
    case GeezaProBold = "GeezaPro-Bold"
    
    case SFUITextRegular = "SFUIText-Regular"
    case HelveticaNeue = "HelveticaNeue"
}

public extension UIFont{
    public static func appFont(font: Font, pontSize: CGFloat) -> UIFont {
        return UIFont.init(name: font.rawValue, size: pontSize)!
    }
}
