//
//  Color+custom.swift
//  71stStreet
//
//  Created by Pantera Engineering on 21/11/2016.
//  Copyright © 2016 Incubasys IT Solutions. All rights reserved.
//

import Foundation
import UIKit

public struct ColorHexCodes{
    public static var values = [Color.Light.rawValue: 0xFFFFFF,Color.Dark.rawValue: 0x273038,
                         Color.Medium.rawValue: 0xB5B0B0,
                         Color.DarkText.rawValue: 0x030303,Color.LightText.rawValue: 0xFFFFFF,
                         Color.Primary.rawValue: 0x0084b4, Color.PrimaryDark.rawValue: 0x006987,
                         Color.Secondary.rawValue: 0xE8963E,
                         Color.Destructive.rawValue: 0xBF2326,Color.Constructive.rawValue: 0x4B58A7,
                         Color.Header.rawValue: 0xEFEFEF]
//    Color.Primary.rawValue: 0x4B58A7
//    0x0058A1
}

public enum Color: String{
    case Light = "Light"
    case Medium = "Medium"
    case Dark = "Dark"
    case DarkText = "DarkText"
    case LightText = "LightText"
    case Primary = "Primary"
    case PrimaryDark = "PrimaryDark"
    case Secondary = "Secondary"
    case Destructive = "Destructive"
    case Constructive = "Constructive"
    case Header = "Header"
}

public extension UIColor{
    
     private convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    public convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
    
    public convenience init(hexString: String,alpha:CGFloat = 1.0) {
        // Convert hex string to an integer
        var hex: UInt32 = 0
        let scanner: Scanner = Scanner(string: hexString)
        scanner.scanHexInt32(&hex)
        
        let hexInt = Int(hex)
        let red = CGFloat((hexInt & 0xff0000) >> 16) / 255.0
        let green = CGFloat((hexInt & 0xff00) >> 8) / 255.0
        let blue = CGFloat((hexInt & 0xff) >> 0) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    public func toRgba() -> [CGFloat] {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        
        if getRed(&r, green: &g, blue: &b, alpha: &a){
            return [r,g,b,a]
        }
        
        return[0,0,0,0]
    }
    
    public func toRgbaString() -> String{
        let rgba = toRgba()
        return "RGB(\(rgba[0]*255),\(rgba[1]*255),\(rgba[2]*255),\(rgba[3]))"
    }
    
    public func toHexString() -> String {
        
        let rgba = toRgba()
        let rgb:Int = (Int)(rgba[0]*255)<<16 | (Int)(rgba[1]*255)<<8 | (Int)(rgba[2]*255)<<0
        
        return String(format: "#%06x", rgb)
    }

    public static func appColor(color:Color) -> UIColor {
        return UIColor(netHex: ColorHexCodes.values[color.rawValue]!)
    }
  
}
