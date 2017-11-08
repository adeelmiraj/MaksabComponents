//
//  UIImage+custom.swift
//  MaksabComponents
//
//  Created by Mansoor Ali on 08/11/2017.
//

import Foundation

extension UIImage{
    static func image(named: String)-> UIImage?{
        return UIImage(named: named, in: Bundle.maksabComponentsBundle(), compatibleWith: nil)
    }
    
    static func localizedImage(named: String)-> UIImage?{
        return UIImage(named: named, in: Bundle.maksabComponentsAssetBundle(), compatibleWith: nil)
    }
}

extension UIImageView{
    func setImg(named: String, redneringMode: UIImageRenderingMode = .alwaysOriginal)  {
        self.image = UIImage.image(named: named)?.withRenderingMode(redneringMode)
    }
    
    func setLocalizedImg(named: String, redneringMode: UIImageRenderingMode = .alwaysOriginal)  {
        self.image = UIImage.localizedImage(named: named)?.withRenderingMode(redneringMode)
    }
}
