//
//  RidesActionViewTemplate.swift
//  Pods
//
//  Created by Incubasys on 02/08/2017.
//
//

import UIKit
import StylingBoilerPlate

class RidesActionViewTemplate: UIView, CustomView, NibLoadableView {

    let bundle = Bundle(for: RidesActionViewTemplate.classForCoder())
    var view: UIView!
    let animationTime: Double = 1
    @IBOutlet weak public var contentView: UIView!
    @IBOutlet weak public var button: UIButton!
    
    override required init(frame: CGRect) {
        super.init(frame: frame)
        view = commonInit(bundle: bundle)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        view = commonInit(bundle: bundle)
    }
    
    public func hide(animated: Bool, completion: @escaping(()->Void)){
        let t = self.transform
        let newTransform = CGAffineTransform(a: t.a, b: t.b, c: t.c, d: t.d, tx: 0, ty: self.view.frame.size.height)
        changeTransform(transform: newTransform, animated: animated, completion: completion)
    }
    
    public func show(animated: Bool, completion: @escaping(()->Void))  {
        let t = self.transform
        let newTransform = CGAffineTransform(a: t.a, b: t.b, c: t.c, d: t.d, tx: 0, ty: 0)
        changeTransform(transform: newTransform, animated: animated, completion: completion)
    }
    
    func changeTransform(transform:CGAffineTransform , animated: Bool,  completion: @escaping(()->Void)) {
        if animated{
            UIView.animate(withDuration: animationTime, animations: { 
                self.view.transform = transform
            }, completion: { (finished) in
                completion()
            })
        }else{
            self.view.transform = transform
            completion()
        }
    }

}
