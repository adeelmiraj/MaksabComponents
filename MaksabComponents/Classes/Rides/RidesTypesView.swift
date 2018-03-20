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
    case economy = 5
    case business = 6
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
        let inst = RidesTypesView(frame: CGRect(x: x, y: y, width: width, height: 90))
        return inst
    }
    
    let bundle = Bundle(for: RidesTypesView.classForCoder())
    
    @IBOutlet weak var btnNormal: ToggleBottomTitleButton!
    @IBOutlet weak var btnBudget: ToggleBottomTitleButton!
    @IBOutlet weak var btnExotic: ToggleBottomTitleButton!
    @IBOutlet weak public var estimateBudget: UILabel!
    @IBOutlet weak public var estimateEconomy: CalloutLabel!
    
    @IBOutlet weak public var estimateBusiness: CalloutLabel!
    var view: UIView!
    
    var selectedRideType = RideType.normal
    var selectedButton: ToggleBottomTitleButton!
//    var isShowOnlyNormalRide: Bool = false
    
    public var delegate: RidesTypesViewDelegate?
    
    var titleNormal: String = ""
    var titleEconomy: String = ""
    var titleBusiness: String = ""
    var titleBudget: String = ""
    var titleLuxury: String = ""
    
    var capacity: RideCapacity = .fourSitter{
        didSet{
            updateCarIcons(capacity: capacity)
        }
    }
    
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
        
        titleNormal = Bundle.localizedStringFor(key: "ride-type-normal-title")
        titleEconomy = Bundle.localizedStringFor(key: "ride-type-economy-title")
        titleBusiness = Bundle.localizedStringFor(key: "ride-type-business-title")
        titleBudget = Bundle.localizedStringFor(key: "ride-type-budget-title")
        titleLuxury = Bundle.localizedStringFor(key: "ride-type-luxury-title")

        selectedButton = btnNormal
        
        updateCarIcons(capacity: capacity)
//        btnNormal.setImage(UIImage.localizedImage(named: "normal-car"), for: .normal)
//        btnBudget.setImage(UIImage.localizedImage(named: "budget-car"), for: .normal)
//        btnExotic.setImage(UIImage.localizedImage(named: "luxury-car"), for: .normal)
        
        btnNormal.setTitle(titleNormal, for: .normal)
        btnBudget.setTitle(titleEconomy, for: .normal)
        btnExotic.setTitle(titleBusiness, for: .normal)
        
        btnNormal.toggleDelegate = self
        btnBudget.toggleDelegate = self
        btnExotic.toggleDelegate = self
        
        estimateBudget.minimumScaleFactor = 0.7
        estimateEconomy.minimumScaleFactor = 0.7
        estimateBusiness.minimumScaleFactor = 0.7
        
        estimateBudget.adjustsFontSizeToFitWidth = true
        estimateEconomy.adjustsFontSizeToFitWidth = true
        estimateBusiness.adjustsFontSizeToFitWidth = true
        
        estimateBudget.font = UIFont.appFont(font: .RubikRegular, pontSize: 10)
        estimateEconomy.font = estimateBudget.font
        estimateBusiness.font = estimateBudget.font
        estimateBudget.text = ""
        estimateEconomy.text = ""
        estimateBusiness.text = ""
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    public func showOnlyNormalRide()  {
        btnBudget.isHidden = true
        btnExotic.isHidden = true
        btnNormal.setImage(normalCar(capacity: capacity), for: .normal)
        btnNormal.setTitle(titleNormal, for: .normal)
        btnNormal.stateSelected = true
        btnNormal.isUserInteractionEnabled = false
        selectedRideType = .schedule
    }
    
    public func showOnlyBudgetRide()  {
        btnBudget.isHidden = true
        btnExotic.isHidden = true
        btnNormal.setImage(economyCar(capacity: capacity), for: .normal)
        btnNormal.setTitle(titleBudget, for: .normal)
        btnNormal.stateSelected = true
        btnNormal.isUserInteractionEnabled = false
        selectedRideType = .budget
    }
    
    public func showOnlyLuxuryRide()  {
        btnBudget.isHidden = true
        btnExotic.isHidden = true
        btnNormal.setImage(businessCar(capacity: capacity), for: .normal)
        btnNormal.setTitle(titleLuxury, for: .normal)
        btnNormal.isUserInteractionEnabled = false
        btnNormal.stateSelected = true
        selectedRideType = .luxury
    }

    public func setCapacity(capacity: RideCapacity)  {
        self.capacity = capacity
    }
    
    func updateCarIcons(capacity: RideCapacity){
        if selectedRideType == .budget{
            btnNormal.setImage(economyCar(capacity: capacity), for: .normal)
        }else if selectedRideType == .luxury{
            btnNormal.setImage(businessCar(capacity: capacity), for: .normal)
        }else{
            btnNormal.setImage(normalCar(capacity: capacity), for: .normal)
            btnBudget.setImage(economyCar(capacity: capacity), for: .normal)
            btnExotic.setImage(businessCar(capacity: capacity), for: .normal)
        }
    }
    
    func normalCar(capacity: RideCapacity) -> UIImage? {
        switch capacity {
        case .fourSitter:
            return UIImage.image(named: "sedan-normal")
        case .sevenSitter:
            return UIImage.image(named: "suv-normal")
        }
    }
    
    func economyCar(capacity: RideCapacity) -> UIImage? {
        switch capacity {
        case .fourSitter:
            return UIImage.image(named: "sedan-economy")
        case .sevenSitter:
            return UIImage.image(named: "suv-economy")
        }
    }
    
    func businessCar(capacity: RideCapacity) -> UIImage? {
        switch capacity {
        case .fourSitter:
            return UIImage.image(named: "sedan-business")
        case .sevenSitter:
            return UIImage.image(named: "suv-business")
        }
    }
    
    public func onToggle(stateSelected: Bool,sender: UIButton) {
      
        let btn = (sender as! ToggleBottomTitleButton)
        
        //deselecte selected button
        selectedButton.stateSelected = false
        
        btn.stateSelected = true
        if btn == btnNormal{
            selectedRideType = .normal
            selectedButton = btnNormal
        }else if btn == btnBudget{
            selectedRideType = .economy
            selectedButton = btnBudget
        }else if btn == btnExotic{
            selectedRideType = .business
            selectedButton = btnExotic
        }
        delegate?.rideTypeToggled(rideType: selectedRideType)
    }
    
    func select(type: RideType)  {
        switch type {
        case .normal:
            btnNormal.stateSelected = true
            selectedButton = btnNormal
        case .economy:
            btnBudget.stateSelected = true
            selectedButton = btnBudget
        case .business:
            btnExotic.stateSelected = true
            selectedButton = btnExotic
        case .budget:
            showOnlyBudgetRide()
        case .luxury:
            showOnlyLuxuryRide()
        case .schedule:
            showOnlyNormalRide()
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
//        if isShowOnlyNormalRide{
//            return .schedule
//        }else{
            return selectedRideType
//        }
    }
}
