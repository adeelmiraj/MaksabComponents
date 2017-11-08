//
//  RidesTypesView.swift
//  Pods
//
//  Created by Incubasys on 02/08/2017.
//
//

import UIKit
import StylingBoilerPlate

public enum RideType: Int {
    case normal = 0
    case delivery = 1
    case budget = 2
    case luxury = 3
    case schedule = 4
}

public protocol RidesTypesViewDelegate {
    func rideTypeToggled(rideType: RideType)
}
public class RidesTypesView: UIView, CustomView, NibLoadableView, Toggleable{

    
    static public func createInstance(x: CGFloat, y: CGFloat, width:CGFloat) -> RidesTypesView{
        let inst = RidesTypesView(frame: CGRect(x: x, y: y, width: width, height: 122))
        return inst
    }
    
    let bundle = Bundle(for: RidesTypesView.classForCoder())
    
    @IBOutlet weak var btnNormal: ToggleBottomTitleButton!
    @IBOutlet weak var btnBudget: ToggleBottomTitleButton!
    @IBOutlet weak var btnExotic: ToggleBottomTitleButton!
    @IBOutlet weak public var estimateBudget: UILabel!
    
    var view: UIView!
    
    var selectedRideType = RideType.normal
    var selectedButton: ToggleBottomTitleButton!
    var isShowNormalRide: Bool = false
    
    public var delegate: RidesTypesViewDelegate?
    
    override public required init(frame: CGRect) {
        super.init(frame: frame)
        view = commonInit(bundle: bundle)
        configView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        view = commonInit(bundle: bundle)
        configView()
    }
    
    func configView()  {
        
        selectedButton = btnNormal
        
        btnNormal.setImage(UIImage.image(named: "normal-car"), for: .normal)
        btnBudget.setImage(UIImage.image(named: "budget-car"), for: .normal)
        btnExotic.setImage(UIImage.image(named: "luxury-car"), for: .normal)
        
        btnNormal.setTitle("Normal", for: .normal)
        btnBudget.setTitle("Budget", for: .normal)
        btnExotic.setTitle("Luxury", for: .normal)
        
        btnNormal.toggleDelegate = self
        btnBudget.toggleDelegate = self
        btnExotic.toggleDelegate = self
    }
    
    public func showOnlyNormalRide()  {
        isShowNormalRide = true
        btnNormal.isHidden = true
        btnExotic.isHidden = true
        btnBudget.setImage(UIImage.image(named: "normal-car"), for: .normal)
        btnBudget.setTitle("Normal", for: .normal)
        btnBudget.stateSelected = true
    }

    public func onToggle(stateSelected: Bool,sender: UIButton) {
      
        //deselecte selected button
        selectedButton.stateSelected = false
        
        let btn = (sender as! ToggleBottomTitleButton)
        
        if btn == btnNormal{
            selectedRideType = .normal
            selectedButton = btnNormal
        }else if btn == btnBudget{
            selectedRideType = .budget
            selectedButton = btnBudget
        }else if btn == btnExotic{
            selectedRideType = .luxury
            selectedButton = btnExotic
        }
        delegate?.rideTypeToggled(rideType: selectedRideType)
    }
    
    func select(type: RideType)  {
        switch type {
        case .normal:
            btnNormal.stateSelected = true
            selectedButton = btnNormal
        case .budget:
            btnBudget.stateSelected = true
            selectedButton = btnBudget
        case .luxury:
            btnExotic.stateSelected = true
            selectedButton = btnExotic
        default:
            return
        }
        selectedRideType = type
    }

    public func changeSelectedType(newType: RideType)  {
        
        //deselect
        selectedButton.stateSelected = false
        
        //select new
        select(type: newType)
    }
    
    public func getSelectedRideType() -> RideType{
        if isShowNormalRide{
            return .schedule
        }else{
            return selectedRideType
        }
    }
}
