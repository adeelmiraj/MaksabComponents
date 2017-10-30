//
//  RideOptionsLinearView.swift
//  Pods
//
//  Created by Incubasys on 04/08/2017.
//
//

import UIKit
import StylingBoilerPlate

public class RideOptionsLinearView: UIView , CustomView, NibLoadableView{
    
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
    
    var view: UIView!
    var rideOptions: RideOptions?
    
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
        btnMehramRide.selectedStateImage = bh.getImageFromMaksabComponent(name: "mehram-selected", _class: RidesOptionsGridView.self)
        btnMehramRide.unSelectedStateImage = bh.getImageFromMaksabComponent(name: "mehram", _class: RidesOptionsGridView.self)
        
        btnNoSmoking.selectedStateImage = bh.getImageFromMaksabComponent(name: "smoking", _class: RidesOptionsGridView.self)
        btnNoSmoking.unSelectedStateImage = bh.getImageFromMaksabComponent(name: "no-smoking", _class: RidesOptionsGridView.self)
        
        btnPayment.selectedStateImage = bh.getImageFromMaksabComponent(name: "budget-car", _class: RidesOptionsGridView.self)
        btnPayment.unSelectedStateImage = bh.getImageFromMaksabComponent(name: "budget-car", _class: RidesOptionsGridView.self)
        
        btnNoOfPassegners.selectedStateImage = bh.getImageFromMaksabComponent(name: "passengers", _class: RidesOptionsGridView.self)
        btnNoOfPassegners.unSelectedStateImage = bh.getImageFromMaksabComponent(name: "passengers", _class: RidesOptionsGridView.self)
        
        btnMehramRide.setTitle("", for: .normal)
        btnNoSmoking.setTitle("", for: .normal)
        btnPayment.setTitle("", for: .normal)
        btnNoOfPassegners.setTitle("", for: .normal)
        /*
        btnMehramRide.toggleDelegate = self
        btnNoSmoking.toggleDelegate = self
        btnPayment.toggleDelegate = self
        btnNoOfPassegners.toggleDelegate = self*/
    }
    /*
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
    }*/
    
    //MARK:- Setters
    public func config(rideOptions: RideOptions){
        btnMehramRide.stateSelected = rideOptions.isMehram
        btnNoSmoking.stateSelected = rideOptions.isSmoking
        setPayment(paymentInfo: rideOptions.paymentInfo)
        self.rideOptions = rideOptions
        //refresh btn
        btnNoOfPassegners.stateSelected = btnNoOfPassegners.stateSelected
    }
    

    //Payment
    public func setPayment(paymentInfo: PaymentInfo){
        let bh = BundleHelper(resourceName: Constants.resourceName)
        var icon: UIImage!
        switch paymentInfo.mehtod {
        case .cash:
            icon = bh.getImageFromMaksabComponent(name: "cash-circle", _class: RideOptionsLinearView.self)
        case .wallet:
            icon = bh.getImageFromMaksabComponent(name: "wallet-card", _class: RideOptionsLinearView.self)
        case .card:
            icon = bh.getImageFromMaksabComponent(name: "credit-card", _class: RideOptionsLinearView.self)
        }
        btnPayment.setImage(icon.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    //MARK:- Getters
    public func getRideOptions() -> RideOptions {
        guard rideOptions != nil else {
            return RideOptions()
        }
        return rideOptions!
    }
}

