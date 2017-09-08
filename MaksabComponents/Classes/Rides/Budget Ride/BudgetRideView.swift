//
//  BudgetRideTemplateView.swift
//  Pods
//
//  Created by Incubasys on 04/08/2017.
//
//

import UIKit
import StylingBoilerPlate

public protocol BudgetRideViewDelegate{
    func toggleRideOption(rideOption: RideOptions, state: Bool)
    func searchRides()
}

public class BudgetRideView: UIView, NibLoadableView{
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var iconCaption: TitleLabel!
    @IBOutlet weak var labelFieldhead: CaptionLabel!
    @IBOutlet weak public var fieldBudget: DarkBorderTextField!
    
    @IBOutlet weak var buttonsContainerView: UIView!
    
    
    let bundle = Bundle(for: BudgetRideView.classForCoder())
    var contentView: UIView!
    var rideOptionsLinearView: RideOptionsLinearView!
    var delegate: BudgetRideViewDelegate?
    
    static public let height: CGFloat = 326
    var templateView: RidesActionViewTemplate!
    
    static public func createInstance(x: CGFloat, y: CGFloat = UIScreen.main.bounds.height - BudgetRideView.height, width: CGFloat, delegate: BudgetRideViewDelegate) -> BudgetRideView{
        let inst = BudgetRideView(frame: CGRect(x: x, y: y, width: width, height: height))
        inst.delegate = delegate
        return inst
    }
    
    override required public init(frame: CGRect) {
        super.init(frame: frame)
        contentView = commonInit(bundle: bundle)
        configView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        contentView = commonInit(bundle: bundle)
        configView()
    }
    
    
    func commonInit(bundle: Bundle) -> UIView{
        let nib = bundle.loadNibNamed(BudgetRideView.nibName, owner: self, options: nil)
        let tempView = nib?.first as? UIView
        guard (tempView) != nil else {
            fatalError("unable to load custom view")
        }
        tempView!.frame = self.bounds
        tempView!.autoresizingMask = [.flexibleWidth,.flexibleHeight]
//        self.addSubview(tempView!)
        return tempView!
    }
    
    func configView()  {
        
        let bh = BundleHelper(resourceName: Constants.resourceName)
        
        fieldBudget.keyboardType = .numberPad
        iconCaption.text = Localization.budgetRide.localized(bundle: bundle)
        icon.image = bh.getImageFromMaksabComponent(name: "budget-car", _class: BudgetRideView.self)
        fieldBudget.placeholder = Localization.priceUnit.localized(bundle: bundle)
        
        templateView = RidesActionViewTemplate(frame: self.bounds)
        templateView.button.setTitle("Search Rides", for: .normal)
        templateView.button.addTarget(self, action: #selector(searchRides), for: .touchUpInside)
        self.addSubview(templateView)
        templateView.hide(animated: false){}
        
        //add BudgetRideView.xib
        contentView.frame = templateView.contentView.bounds
        templateView.contentView.addSubview(contentView)
        
        //add RideOptionsLinearView
        rideOptionsLinearView = RideOptionsLinearView.createInstance(x: 0, y: 0, width: self.frame.size.width)
        rideOptionsLinearView.delegate = self
        buttonsContainerView.addSubview(rideOptionsLinearView)
    }
    
    public func show(animated: Bool, completion: (() -> Void)? = nil){
        templateView.show(animated: animated, completion: completion)
    }
    
    public func hide(animated: Bool, completion: (() -> Void)? = nil){
        templateView.hide(animated: animated, completion: completion)
    }
    
    func searchRides()  {
        delegate?.searchRides()
    }
    
}

extension BudgetRideView: RideOptionsDelegate{
    
    public func rideOptioinToggled(rideOption: RideOptions, state: Bool){
        delegate?.toggleRideOption(rideOption: rideOption, state: state)
    }
    
    public func isMehramRide() -> Bool{
        return rideOptionsLinearView.btnMehramRide.stateSelected
    }
    
    public func isNoSmoking() -> Bool{
        return rideOptionsLinearView.btnNoSmoking.stateSelected
    }
}
