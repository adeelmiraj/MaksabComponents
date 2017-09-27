//
//  SlidableView.swift
//  Pods
//
//  Created by Incubasys on 26/09/2017.
//
//

import Foundation
public protocol SlidableView{}

public extension SlidableView where Self:UIView {
    public var animationTime: Double {
        get{
            return self.animationTime
        }
        set(newVal){
            animationTime = newVal
        }
    }
    
    public func hide(animated: Bool, animationTime: Double = 0.5, completion: (() -> Void)? = nil){
        let t = self.transform
        let newTransform = CGAffineTransform(a: t.a, b: t.b, c: t.c, d: t.d, tx: 0, ty: self.frame.size.height)
        changeTransform(transform: newTransform, animated: animated, animationTime: animationTime, completion: completion)
    }
    
    public func show(animated: Bool, animationTime: Double = 0.5, completion: (() -> Void)? = nil)  {
        let t = self.transform
        let newTransform = CGAffineTransform(a: t.a, b: t.b, c: t.c, d: t.d, tx: 0, ty: 0)
        changeTransform(transform: newTransform, animated: animated, animationTime: animationTime, completion: completion)
    }
    
    func changeTransform(transform:CGAffineTransform , animated: Bool, animationTime: Double, completion: (() -> Void)? = nil) {
        if animated{
            UIView.animate(withDuration: animationTime, animations: {
                self.transform = transform
            }, completion: { (finished) in
                completion?()
            })
        }else{
            self.transform = transform
            completion?()
        }
    }
}
