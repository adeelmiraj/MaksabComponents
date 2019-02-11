//
//  RidesOptionsGridView.swift
//  Pods
//
//  Created by Incubasys on 02/08/2017.
//
//

import UIKit
import StylingBoilerPlate

public enum RideCapacity: Int {
    case fourSitter = 1
    case sevenSitter = 2
    
    public func getCount() -> Int {
        switch self {
        case .fourSitter:
            return 4
        case .sevenSitter:
            return 7
        }
    }
    
    public func carIcon(rideType: RideType) -> UIImage? {
        var iconName: String = ""
        switch rideType {
        case .budget,.economy:
            iconName = "sedan-economy"
        case .business,.luxury:
            iconName = "sedan-business"
        default:
            iconName = "sedan-normal"
        }
        iconName = carImageName(forCapacity: self, imgName: iconName)
        return UIImage.image(named: iconName)
    }
    
    private func carImageName(forCapacity: RideCapacity, imgName: String) -> String {
        switch  forCapacity {
        case .sevenSitter:
            return imgName.replacingOccurrences(of: "sedan", with: "suv")
        default:
            return imgName
        }
    }
}

public enum PaymentMethod: Int {
	case cash = 0
	case card = 1
	case wallet = 2

	public func getTitle() -> String {
		switch self {
		case .card:
			return Bundle.localizedStringFor(key: "Credit Card")
		case .cash:
			return Bundle.localizedStringFor(key: "Cash")
		case .wallet:
			return Bundle.localizedStringFor(key: "Wallet")
		}
	}
}

/*

public class PaymentInfo{
    public var mehtod: PaymentMethod
    public var cardId: Int?
    
    public init(method: PaymentMethod, cardId: Int? = nil) {
        self.mehtod = method
        self.cardId = cardId
    }
}


public struct PaymentOptions{
    var title: String = ""
    var id: Int = -1
    public init(){}
    
    public init(title: String, id: Int){
        self.title = title
        self.id = id
    }
    
    static func createPaymentOptions() -> [PaymentOptions] {
        
        let optionCash = PaymentOptions(title: Bundle.localizedStringFor(key: "payment-method-cash"), id: -1)
        let optionWallet = PaymentOptions(title: Bundle.localizedStringFor(key: "ride-options-wallet"), id: -1)
        return [optionCash,optionWallet]
    }
}
*/
public protocol RideOptionsGridViewDelegate: class {
	func rideOptionsGridViewDidSelectMehram()
	func rideOptionsGridViewDidSelectPayment()
}

public class RidesOptionsGridView: UIView, CustomView, NibLoadableView, ToggleViewDelegate{

    static public func createInstance(x: CGFloat, y: CGFloat, width:CGFloat) -> RidesOptionsGridView{
        let inst = RidesOptionsGridView(frame: CGRect(x: x, y: y, width: width, height: 72))
        return inst
    }
    
    let bundle = Bundle(for: RidesOptionsGridView.classForCoder())
    
    @IBOutlet weak public var mehramView: ToggleView!
    @IBOutlet weak var paymentView: ToggleView!
    
    var view: UIView!
//    var capacity = RideCapacity.fourSitter
//    var availablePayments = PaymentOptions.createPaymentOptions()
    var selectedPaymentId: Int = 0
	public weak var delegate: RideOptionsGridViewDelegate?
    
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
//
//        mehramView.selectedStateImg = UIImage.image(named: "mehram-selected")
//        mehramView.unSelectedStateImg = UIImage.image(named: "mehram")
//
//        mehramView.selectedStateTitle = Bundle.localizedStringFor(key: "ride-options-mehram")
//        mehramView.unSelectedStateTitle = Bundle.localizedStringFor(key: "ride-options-non-mehram")

        mehramView.title.numberOfLines = 2
        mehramView.state = false
		mehramView.toggeable = self
		mehramView.autoToggle = false
        
        paymentView.icon.image = UIImage.image(named: "cash-circle")
        paymentView.title.text = Bundle.localizedStringFor(key: "payment-method-cash")

        paymentView.toggeable = self
		paymentView.autoToggle = false

    }

    
    //Payment
	public func setPayment(title: String, image: UIImage?){
		paymentView.icon.image = image
		paymentView.title.text = title
    }

	public func setMehram(title: String, image: UIImage?){
		mehramView.icon.image = image
		mehramView.title.text = title
	}
    
    public func viewToggled(state: Bool, view: ToggleView) {
        if view == paymentView{
			delegate?.rideOptionsGridViewDidSelectPayment()
		}else {
			delegate?.rideOptionsGridViewDidSelectMehram()
		}
    }
}
