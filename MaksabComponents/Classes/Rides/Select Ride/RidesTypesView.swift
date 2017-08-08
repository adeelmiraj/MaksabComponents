//
//  RidesTypesView.swift
//  Pods
//
//  Created by Incubasys on 02/08/2017.
//
//

import UIKit
import StylingBoilerPlate

public enum RideType: Int{
    case Normal = 0
    case Budget = 1
    case Luxury = 2
}

protocol RideTypesDelegate{
    func rideTypeChanged(rideType: RideType)
}
class RidesTypesView: UIView, CustomView, NibLoadableView, Toggleable{

    
    static func createInstance(x: CGFloat, y: CGFloat, width:CGFloat) -> RidesTypesView{
        let inst = RidesTypesView(frame: CGRect(x: x, y: y, width: width, height: 122))
        return inst
    }
    
    let bundle = Bundle(for: RidesTypesView.classForCoder())
    
    @IBOutlet weak var btnNormal: ToggleBottomTitleButton!
    @IBOutlet weak var btnBudget: ToggleBottomTitleButton!
    @IBOutlet weak var btnExotic: ToggleBottomTitleButton!
    @IBOutlet weak var estimateBudget: UILabel!
    
    var view: UIView!
    
    var selectedRideType: RideType = .Normal
    
    var selectedButton: ToggleBottomTitleButton!
    
    public var delegate: RideTypesDelegate?
    
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
        
        selectedButton = btnNormal
        
        let bh = BundleHelper(resourceName: Constants.resourceName)
        btnNormal.setImage(bh.getImageFromMaksabComponent(name: "normal-car", _class: RidesTypesView.self), for: .normal)
        btnBudget.setImage(bh.getImageFromMaksabComponent(name: "budget-car", _class: RidesTypesView.self), for: .normal)
        btnExotic.setImage(bh.getImageFromMaksabComponent(name: "luxury-car", _class: RidesTypesView.self), for: .normal)
        
        btnNormal.setTitle("Normal", for: .normal)
        btnBudget.setTitle("Budget", for: .normal)
        btnExotic.setTitle("Luxury", for: .normal)
        
        btnNormal.toggleDelegate = self
        btnBudget.toggleDelegate = self
        btnExotic.toggleDelegate = self
    }

    func onToggle(stateSelected: Bool,sender: UIButton) {
      
        //deselecte selected button
        selectedButton.stateSelected = false
        
        let btn = (sender as! ToggleBottomTitleButton)
        
        if btn == btnNormal{
            selectedRideType = .Normal
            selectedButton = btnNormal
        }else if btn == btnBudget{
            selectedRideType = .Budget
            selectedButton = btnBudget
        }else if btn == btnExotic{
            selectedRideType = .Luxury
            selectedButton = btnExotic
        }
        delegate?.rideTypeChanged(rideType: selectedRideType)
    }
    
    func select(type: RideType)  {
        switch type {
        case .Normal:
            btnNormal.stateSelected = true
            selectedButton = btnNormal
        case .Budget:
            btnBudget.stateSelected = true
            selectedButton = btnBudget
        case .Luxury:
            btnExotic.stateSelected = true
            selectedButton = btnExotic
        }
        selectedRideType = type
    }

    public func changeSelectedType(newType: RideType)  {
        
        if newType == selectedRideType{
            return
        }
        
        //deselect
        selectedButton.stateSelected = false
        
        //select new
        select(type: newType)
    }
    
    public func getSelectedRideType() -> RideType{
        return selectedRideType
    }
}
