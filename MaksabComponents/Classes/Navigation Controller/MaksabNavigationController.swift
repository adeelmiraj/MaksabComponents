//
//  MaksabNavigationController.swift
//  Pods
//
//  Created by Incubasys on 20/07/2017.
//
//

import UIKit
import StylingBoilerPlate

open class MaksabNavigationController: UINavigationController {
    
    @IBInspectable public var isTransparent: Bool = true {
        didSet{
            setBarStyle(_isTransparent: isTransparent)
        }
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        setBarStyle(_isTransparent: isTransparent)
        self.navigationBar.topItem?.title = ""
        // Do any additional setup after loading the view.
    }

    func setBarStyle(_isTransparent: Bool) {
        if _isTransparent{
            let img = UIImage.getImageFromColor(color: UIColor.clear, size: CGSize(width: self.view.frame.size.width, height: 64))
            self.navigationBar.setBackgroundImage(img, for: .default)
            let shadowImg = UIImage.getImageFromColor(color: UIColor.clear, size: CGSize(width: self.view.frame.size.width, height: 1))
            self.navigationBar.shadowImage = shadowImg
        }else{
            let img = UIImage.getImageFromColor(color: UIColor.white, size: CGSize(width: self.view.frame.size.width, height: 64))
            self.navigationBar.setBackgroundImage(img, for: .default)
            let shadowImg = UIImage.getImageFromColor(color: UIColor.appColor(color: .Dark), size: CGSize(width: self.view.frame.size.width, height: 1))
            self.navigationBar.shadowImage = shadowImg
        }
    }
}
