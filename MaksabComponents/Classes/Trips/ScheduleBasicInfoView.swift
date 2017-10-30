//
//  ScheduleBasicInfoView.swift
//  Pods
//
//  Created by Incubasys on 15/09/2017.
//
//

import UIKit
import StylingBoilerPlate

public class ScheduleBasicInfoView: UIView, CustomView, NibLoadableView {
    
    @IBOutlet weak var otherInfo: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var time: UILabel!
    
    let bundle = Bundle(for: ScheduleBasicInfoView.classForCoder())
    var view: UIView!
    public static let height: CGFloat = 52

    static public func createInstance(x: CGFloat, y: CGFloat = 0, width: CGFloat) -> ScheduleBasicInfoView{
        let inst = ScheduleBasicInfoView(frame: CGRect(x: x, y: y, width: width, height: ScheduleBasicInfoView.height))
        return inst
    }
    
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
        view.backgroundColor = UIColor.clear
        self.backgroundColor = UIColor.appColor(color: .Light)
        price.font = UIFont.appFont(font: .RubikMedium, pontSize: 15)
        price.textColor = UIColor.appColor(color: .DarkText)
    }
    
    public func config(otherInfo: String, price: String, time: String){
        self.otherInfo.text = otherInfo
        self.price.text = price
        self.time.text = time
    }
}
