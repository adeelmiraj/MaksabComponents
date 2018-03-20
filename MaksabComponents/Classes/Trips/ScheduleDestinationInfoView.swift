//
//  ScheduleBasicInfoView.swift
//  Pods
//
//  Created by Incubasys on 15/09/2017.
//
//

import UIKit
import StylingBoilerPlate

public class ScheduleDestinationInfoView: UIView, CustomView, NibLoadableView {
    
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var origin: UILabel!
    @IBOutlet weak var destination: UILabel!
    
    let bundle = Bundle(for: ScheduleDestinationInfoView.classForCoder())
    var view: UIView!
    public static let height: CGFloat = 118

    static public func createInstance(x: CGFloat, y: CGFloat = 0, width: CGFloat) -> ScheduleDestinationInfoView{
        let inst = ScheduleDestinationInfoView(frame: CGRect(x: x, y: y, width: width, height: ScheduleDestinationInfoView.height))
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
    }
    
    public func config(distance: NSAttributedString, origin: String, destination: String){
        self.distance.attributedText = distance
        self.origin.text = origin
        self.destination.text = destination
    }
}
