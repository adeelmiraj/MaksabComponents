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
    var noOfPassengers = 2
    
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
        btnMehramRide.selectedStateImage = bh.getImageFromMaksabComponent(name: "mehram-selected", _class: RidesOptionsGridView.self)
        btnMehramRide.unSelectedStateImage = bh.getImageFromMaksabComponent(name: "mehram", _class: RidesOptionsGridView.self)
        btnMehramRide.stateSelected = false
        
        btnNoSmoking.selectedStateImage = bh.getImageFromMaksabComponent(name: "smoking", _class: RidesOptionsGridView.self)
        btnNoSmoking.unSelectedStateImage = bh.getImageFromMaksabComponent(name: "no-smoking", _class: RidesOptionsGridView.self)
        btnNoSmoking.stateSelected = false
        
        btnPayment.selectedStateImage = bh.getImageFromMaksabComponent(name: "cash-circle", _class: RidesOptionsGridView.self)
        btnPayment.unSelectedStateImage = bh.getImageFromMaksabComponent(name: "credit-card", _class: RidesOptionsGridView.self)
        btnPayment.stateSelected = true
        
        btnNoOfPassegners.selectedStateImage = bh.getImageFromMaksabComponent(name: "passengers", _class: RidesOptionsGridView.self)
        btnNoOfPassegners.unSelectedStateImage = bh.getImageFromMaksabComponent(name: "passengers", _class: RidesOptionsGridView.self)
        btnNoOfPassegners.stateSelected = true
        
        btnMehramRide.setTitle("Mehram Ride", for: .normal)
        btnNoSmoking.setTitle("No Smoking", for: .normal)
        btnPayment.setTitle("Cash       ", for: .normal)
        btnNoOfPassegners.setTitle("\(noOfPassengers) or less Passengers", for: .normal)
        
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
            if btnPayment.stateSelected{
                btnPayment.setTitle("Cash       ", for: .normal)
            }else{
                btnPayment.setTitle("Credit Card", for: .normal)
            }
            optionType = .Payment
        }else if btn == btnNoOfPassegners{
            if noOfPassengers == 2{
                noOfPassengers = 5
            }else if noOfPassengers == 5{
                noOfPassengers = 7
            }else if noOfPassengers == 7{
                noOfPassengers = 2
            }
            btnNoOfPassegners.setTitle("\(noOfPassengers) or less Passengers", for: .normal)
            optionType = .NoOfPassengers
        }
        
        delegate?.rideOptioinToggled(rideOption: optionType, state: stateSelected)
    }
    
    public func isMehramRide() -> Bool{
        return btnMehramRide.stateSelected
    }
    
    public func isCashPayment() -> Bool {
        return btnPayment.stateSelected
    }
    
    public func getNoOfPassengers() -> Int {
        return noOfPassengers
    }
    
    public func isNoSmoking() -> Bool{
        return btnNoSmoking.stateSelected
    }
}
