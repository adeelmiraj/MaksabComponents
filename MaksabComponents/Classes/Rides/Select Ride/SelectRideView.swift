//
//  SelectRideView.swift
//  Pods
//
//  Created by Incubasys on 02/08/2017.
//
//

import UIKit

public protocol SelectRideDelegate{
    func toggleRideType(selectedType: RideType)
    func toggleRideOption(rideOption: RideOptions, state: Bool)
    func searchRides()
}

public class SelectRideView: UIView {
    
    static public let height: CGFloat = 370
    var templateView: RidesActionViewTemplate!
    var rideTypesView: RidesTypesView!
    var rideOptionsGridView: RidesOptionsGridView!
    
    public var delegate: SelectRideDelegate?
    
    static public func createInstance(x: CGFloat, y: CGFloat = UIScreen.main.bounds.height - SelectRideView.height, width: CGFloat, delegate: SelectRideDelegate) -> SelectRideView{
        let inst = SelectRideView(frame: CGRect(x: x, y: y, width: width, height: height))
        inst.delegate = delegate
        return inst
    }
    
    override public required init(frame: CGRect) {
        super.init(frame: frame)
        configView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configView()
    }

    func configView()  {
        templateView = RidesActionViewTemplate(frame: self.bounds)
        templateView.button.setTitle("Search Rides", for: .normal)
        self.addSubview(templateView)
        templateView.button.addTarget(self, action: #selector(actSearchRides), for: .touchUpInside)
        templateView.hide(animated: false){}
        
        rideTypesView = RidesTypesView.createInstance(x: 0, y: 0, width: self.frame.size.width)
        rideTypesView.delegate = self
        templateView.contentView.addSubview(rideTypesView)
        
        rideOptionsGridView = RidesOptionsGridView.createInstance(x: 0, y: rideTypesView.frame.size.height, width: self.frame.size.width)
        rideOptionsGridView.delegate = self
        templateView.contentView.addSubview(rideOptionsGridView)
    }
    
    public func show(animated: Bool, completion: (() -> Void)? = nil){
        templateView.show(animated: animated, completion: completion)
    }
    
    public func hide(animated: Bool, completion: (() -> Void)? = nil){
        templateView.hide(animated: animated, completion: completion)
    }
    
    func actSearchRides()  {
        delegate?.searchRides()
    }
}

//MARK:- Ride Types
extension SelectRideView: RideTypesDelegate{
    
    //Ride type
    func rideTypeChanged(rideType: RideType) {
        delegate?.toggleRideType(selectedType: rideType)
    }
    
    public func getSelectedRideType() -> RideType{
       return rideTypesView.getSelectedRideType()
    }
    
    public func changeRideType(newRideType: RideType) {
        rideTypesView.changeSelectedType(newType: newRideType)
    }
}

extension SelectRideView: RideOptionsDelegate{
    func rideOptioinToggled(rideOption: RideOptions, state: Bool) {
        delegate?.toggleRideOption(rideOption: rideOption, state: state)
    }
    
    public func isMehramRide() -> Bool{
        return rideOptionsGridView.isMehramRide()
    }
    
    public func isNoSmoking() -> Bool{
        return rideOptionsGridView.isNoSmoking()
    }
}

