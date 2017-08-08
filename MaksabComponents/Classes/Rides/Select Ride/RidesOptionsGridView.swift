//
//  RidesOptionsGridView.swift
//  Pods
//
//  Created by Incubasys on 02/08/2017.
//
//

import UIKit
import StylingBoilerPlate

public enum RideOptions: Int{
    case MehramRide = 0
    case NoSmoking = 1
    case Payment = 2
    case NoOfPassengers = 3
}

protocol RideOptionsDelegate{
    func rideOptioinToggled(rideOption: RideOptions, state: Bool)
}

class RidesOptionsGridView: UIView, CustomView, NibLoadableView, Toggleable{
    
    
    static func createInstance(x: CGFloat, y: CGFloat, width:CGFloat) -> RidesOptionsGridView{
        let inst = RidesOptionsGridView(frame: CGRect(x: x, y: y, width: width, height: 139))
        return inst
    }
    
    let bundle = Bundle(for: RidesOptionsGridView.classForCoder())
    
    @IBOutlet weak var btnMehramRide: ToggleButton!
    @IBOutlet weak var btnNoSmoking: ToggleButton!
    @IBOutlet weak public var btnPayment: ToggleButton!
    @IBOutlet weak public var btnNoOfPassegners: ToggleButton!
    
    var delegate: RideOptionsDelegate?
    
    var view: UIView!
    
    override required init(frame: CGRect) {
        super.init(frame: frame)
        view = commonInit(bundle: bundle)
        configView()
    }
    
    required init?(coder aDecoder: NSCoder) {
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
    
    func config()  {
    }
    
    func onToggle(stateSelected: Bool, sender: UIButton) {
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
    
    public func isMehramRide() -> Bool{
        return btnMehramRide.stateSelected
    }
    
    public func isNoSmoking() -> Bool{
        return btnNoSmoking.stateSelected
    }
}
