//
//  RideOptionsLinearView.swift
//  Pods
//
//  Created by Incubasys on 04/08/2017.
//
//

import UIKit
import StylingBoilerPlate

public class RideOptionsLinearView: UIView , CustomView, NibLoadableView, Toggleable{
    
    static let height:CGFloat = 39
    static public func createInstance(x: CGFloat, y: CGFloat, width:CGFloat) -> RideOptionsLinearView{
        let inst = RideOptionsLinearView(frame: CGRect(x: x, y: y, width: width, height: RideOptionsLinearView.height))
        return inst
    }
    
    let bundle = Bundle(for: RidesOptionsGridView.classForCoder())
    
    @IBOutlet weak public var btnMehramRide: ToggleButton!
    @IBOutlet weak public var btnNoSmoking: ToggleButton!
    @IBOutlet weak public var btnPayment: ToggleButton!
    @IBOutlet weak public var btnNoOfPassegners: ToggleButton!
    
    public var delegate: RideOptionsDelegate?
    
    var view: UIView!
    
    override public required init(frame: CGRect) {
        super.init(frame: frame)
        view = commonInit(bundle: bundle)
        configView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        view = commonInit(bundle: bundle)
        configView()
    }
    
    func configView()  {
        let bh = BundleHelper(resourceName: Constants.resourceName)
        btnMehramRide.selectedStateImage = bh.getImageFromMaksabComponent(name: "budget-car", _class: RidesOptionsGridView.self)
        btnMehramRide.unSelectedStateImage = bh.getImageFromMaksabComponent(name: "budget-car", _class: RidesOptionsGridView.self)
        
        btnNoSmoking.selectedStateImage = bh.getImageFromMaksabComponent(name: "budget-car", _class: RidesOptionsGridView.self)
        btnNoSmoking.unSelectedStateImage = bh.getImageFromMaksabComponent(name: "budget-car", _class: RidesOptionsGridView.self)
        
        btnPayment.selectedStateImage = bh.getImageFromMaksabComponent(name: "budget-car", _class: RidesOptionsGridView.self)
        btnPayment.unSelectedStateImage = bh.getImageFromMaksabComponent(name: "budget-car", _class: RidesOptionsGridView.self)
        
        btnNoOfPassegners.selectedStateImage = bh.getImageFromMaksabComponent(name: "budget-car", _class: RidesOptionsGridView.self)
        btnNoOfPassegners.unSelectedStateImage = bh.getImageFromMaksabComponent(name: "budget-car", _class: RidesOptionsGridView.self)
        
        btnMehramRide.setTitle("Mehram Ride", for: .normal)
        btnNoSmoking.setTitle("No Smoking", for: .normal)
        btnPayment.setTitle("Credit Card", for: .normal)
        btnNoOfPassegners.setTitle("4 or less Passengers", for: .normal)
        
        btnMehramRide.toggleDelegate = self
        btnNoSmoking.toggleDelegate = self
        btnPayment.toggleDelegate = self
        btnNoOfPassegners.toggleDelegate = self
    }
    
    public func onToggle(stateSelected: Bool, sender: UIButton) {
        let btn = sender as! ToggleButton
        
        var optionType = RideOptions.MehramRide
        if btn == btnMehramRide{
            optionType = .MehramRide
        }else if btn == btnNoSmoking{
            optionType = .NoSmoking
        }else if btn == btnPayment{
            optionType = .Payment
        }else if btn == btnNoOfPassegners{
            optionType = .NoOfPassengers
        }
        
        delegate?.rideOptioinToggled(rideOption: optionType, state: stateSelected)
    }
    
    func isMehramRide() -> Bool{
        return btnMehramRide.stateSelected
    }
    
    func isNoSmoking() -> Bool{
        return btnNoSmoking.stateSelected
    }
}

