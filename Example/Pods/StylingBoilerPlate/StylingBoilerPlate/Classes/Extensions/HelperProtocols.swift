//
//  StoryBoardLoabableView.swift
//  Pods
//
//  Created by Incubasys on 24/07/2017.
//
//

import UIKit

public protocol StoryBoardLoadableView{}
public extension StoryBoardLoadableView where Self: UIViewController{
    public static var sceneName: String {
        let vc = String(describing: self)
        let str = vc.replacingOccurrences(of: "ViewController", with: "Scene")
        return str
    }
}

//Load view from xib file
public protocol CustomView{
    init(frame: CGRect)
}
public extension CustomView where Self: UIView, Self: NibLoadableView{
    
    public func commonInit(bundle: Bundle) -> UIView{
        let nib = bundle.loadNibNamed(Self.nibName, owner: self, options: nil)
        let tempView = nib?.first as? UIView
        guard (tempView) != nil else {
            fatalError("unable to load custom view")
        }
        tempView!.frame = self.bounds
        tempView!.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        self.addSubview(tempView!)
        return tempView!
    }
}
