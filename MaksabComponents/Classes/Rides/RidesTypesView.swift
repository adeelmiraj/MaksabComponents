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
	case special = 7
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
    
    @IBOutlet weak public var normalFare: UILabel!
    @IBOutlet weak public var economyFare: CalloutLabel!
    @IBOutlet weak public var businessFare: CalloutLabel!
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
        
        createRideTypesTitles()

        selectedButton = btnNormal
        
        updateCarIcons(capacity: capacity)
        setupRideTypeButtons()
        setupFareLabels()
        
    }
    
    private func createRideTypesTitles(){
        titleNormal = Bundle.localizedStringFor(key: "ride-type-normal-title")
        titleEconomy = Bundle.localizedStringFor(key: "ride-type-economy-title")
        titleBusiness = Bundle.localizedStringFor(key: "Business")
        titleBudget = Bundle.localizedStringFor(key: "Budget")
        titleLuxury = Bundle.localizedStringFor(key: "ride-type-luxury-title")
    }
    
    private func setupRideTypeButtons(){
        btnNormal.setTitle(titleNormal, for: .normal)
        btnBudget.setTitle(titleEconomy, for: .normal)
        btnExotic.setTitle(titleBusiness, for: .normal)
        
        btnNormal.toggleDelegate = self
        btnBudget.toggleDelegate = self
        btnExotic.toggleDelegate = self
    }
    
    private func setupFareLabels()  {
        let scale: CGFloat = 0.7
        let font = UIFont.appFont(font: .RubikRegular, pontSize: 10)
        
        setup(label: normalFare, scale: scale, font: font)
        setup(label: economyFare, scale: scale, font: font)
        setup(label: businessFare, scale: scale, font: font)
    }
    
    private func setup(label: UILabel, scale: CGFloat, font: UIFont){
        label.font = font
        label.minimumScaleFactor = scale
        label.adjustsFontSizeToFitWidth = true
        label.text = ""
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    public func showOnlyNormalRide()  {
        hideEconomyAndBusinessOptions()
        setupCenterButton(title: titleNormal, icon: normalCar(capacity: capacity))
        selectedRideType = .schedule
    }
    
    public func showOnlyBudgetRide()  {
        hideEconomyAndBusinessOptions()
        setupCenterButton(title: titleBudget, icon: economyCar(capacity: capacity))
        selectedRideType = .budget
    }
    
    public func showOnlyLuxuryRide()  {
        hideEconomyAndBusinessOptions()
        setupCenterButton(title: titleLuxury, icon: businessCar(capacity: capacity))
        selectedRideType = .luxury
    }

    private func hideEconomyAndBusinessOptions(){
        btnBudget.isHidden = true
        btnExotic.isHidden = true
    }
    
    private func setupCenterButton(title: String, icon: UIImage?){
        btnNormal.setImage(icon, for: .normal)
        btnNormal.setTitle(title, for: .normal)
        btnNormal.isUserInteractionEnabled = false
        btnNormal.stateSelected = true
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
