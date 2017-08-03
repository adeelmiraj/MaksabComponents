//
//  BadgeView.swift
//  Pods
//
//  Created by Incubasys on 02/08/2017.
//
//

import UIKit
import StylingBoilerPlate

public class BadgeView: UIView, CustomView, NibLoadableView{

    let bundle = Bundle(for: BadgeView.classForCoder())
    
    @IBOutlet weak public var locationName: UILabel!
    @IBOutlet weak public var subtitle: UILabel!
    @IBOutlet weak public var time: UILabel!
    @IBOutlet weak public var timeUnit: UILabel!
    
    @IBOutlet weak public var timeContainerView: UIView!
    
    
    
    @IBOutlet weak public var arrowView: UIView!
    
    @IBOutlet weak public var borderView: UIView!
    @IBOutlet weak public var curveView: UIView!
    
    var view: UIView!
    
    override required public init(frame: CGRect) {
        super.init(frame: frame)
        let bundle = Bundle(for: type(of: self))
        view = self.commonInit(bundle: bundle)
        configView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let bundle = Bundle(for: type(of: self))
        view = self.commonInit(bundle: bundle)
        configView()
    }
    
    func configView()  {
        timeContainerView.backgroundColor = UIColor.appColor(color: .Dark)
        timeContainerView.layer.cornerRadius = 20

        arrowView.layer.borderColor = UIColor.appColor(color: .Dark).cgColor
        arrowView.layer.borderWidth = 1
        arrowView.transform = arrowView.transform.rotated(by: -CGFloat(Double.pi/4))
        borderView.layer.cornerRadius = 6
        borderView.layer.borderWidth = 1
        borderView.layer.borderColor = UIColor.appColor(color: .Dark).cgColor
        curveView.layer.borderWidth = 1
        curveView.layer.borderColor = UIColor.appColor(color: .Dark).cgColor
        curveView.layer.cornerRadius = 25
        
        
    }
    
    public func config(location: String, distance: String, time: String, timeUnit: String){
        locationName.text = location
        subtitle.text = distance
        self.time.text = time
        self.timeUnit.text = timeUnit
    }

}
