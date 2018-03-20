//
//  RidesOptionsGridView.swift
//  Pods
//
//  Created by Incubasys on 02/08/2017.
//
//

import UIKit
import StylingBoilerPlate

public enum PaymentMethod: Int {
    case cash = 0
    case card = 1
    case wallet = 2
    
    public func getTitle() -> String {
        switch self {
        case .card:
            return Bundle.localizedStringFor(key: "payment-method-credit")
        case .cash:
            return Bundle.localizedStringFor(key: "payment-method-cash")
        case .wallet:
            return Bundle.localizedStringFor(key: "payment-method-wallet")
        }
    }
}

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
}

public class RideOptions{
    public var isMehram: Bool = false
    public var isSmoking: Bool = false
    public var capacity: RideCapacity = .fourSitter
    public var paymentInfo = PaymentInfo(method: .cash)
    
    public init() {}
}

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

public class RidesOptionsGridView: UIView, CustomView, NibLoadableView, ToggleViewDelegate{
    
    
    static public func createInstance(x: CGFloat, y: CGFloat, width:CGFloat) -> RidesOptionsGridView{
        let inst = RidesOptionsGridView(frame: CGRect(x: x, y: y, width: width, height: 72))
        return inst
    }
    
    let bundle = Bundle(for: RidesOptionsGridView.classForCoder())
    
    @IBOutlet weak public var mehramView: ToggleView!
    @IBOutlet weak public var paymentView: ToggleView!
    
    var view: UIView!
    var capacity = RideCapacity.fourSitter
    var availablePayments = PaymentOptions.createPaymentOptions()
    var selectedPaymentOptionIndex: Int = 0
    
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
        
        mehramView.selectedStateImg = UIImage.image(named: "mehram-selected")
        mehramView.unSelectedStateImg = UIImage.image(named: "mehram")
        
        mehramView.selectedStateTitle = Bundle.localizedStringFor(key: "ride-options-mehram")
        mehramView.unSelectedStateTitle = Bundle.localizedStringFor(key: "ride-options-non-mehram")
        mehramView.title.numberOfLines = 2
        mehramView.state = false
        
        paymentView.icon.image = UIImage.image(named: "cash-circle")
        paymentView.title.text = Bundle.localizedStringFor(key: "payment-method-cash")

        paymentView.toggeable = self
        
        let icon = UIImage.image(named: "cash-circle")!
        updatePaymentBtn(title: availablePayments[selectedPaymentOptionIndex].title, img: icon)
    }
    
    public func addCreditCards(creditCards: [PaymentOptions]){
        availablePayments.append(contentsOf: creditCards)
    }
    
    //MARK:- Setters
    public func config(rideOptions: RideOptions){
        setPayment(paymentInfo: rideOptions.paymentInfo)
        mehramView.state = rideOptions.isMehram
    }
    
    //Payment
    public func setPayment(paymentInfo: PaymentInfo){
        var icon: UIImage!
        switch paymentInfo.mehtod {
        case .cash:
            selectedPaymentOptionIndex = 0
            icon = UIImage.image(named: "cash-circle")
        case .wallet:
            selectedPaymentOptionIndex = 1
            icon = UIImage.image(named: "wallet-card")
        case .card:
            if let cardIndex = getIndexForCard(id: paymentInfo.cardId){
                selectedPaymentOptionIndex = cardIndex
                icon = UIImage.image(named: "credit-card")
            }else{
                selectedPaymentOptionIndex = 0
                icon = UIImage.image(named: "cash-circle")
            }
        }
        updatePaymentBtn(title: availablePayments[selectedPaymentOptionIndex].title, img: icon)
    }
    
    func updatePaymentBtn(title: String, img: UIImage)  {
        paymentView.icon.image = img
        paymentView.title.text = title
    }
    
    func getIndexForCard(id: Int?) -> Int? {
        guard  id != nil else {
            return nil
        }
        for i in 2..<availablePayments.count{
            if id == availablePayments[i].id{
                selectedPaymentOptionIndex = i
                break
            }
        }
        return nil
    }
    
    public func viewToggled(state: Bool, view: ToggleView) {
        if view == paymentView{
            if selectedPaymentOptionIndex == availablePayments.count - 1{
                selectedPaymentOptionIndex = 0
            }else{
                selectedPaymentOptionIndex += 1
            }
            var icon: UIImage!
            if selectedPaymentOptionIndex == 0{
                icon = UIImage.image(named: "cash-circle")
            }else if selectedPaymentOptionIndex == 1{
                icon = UIImage.image(named: "wallet-card")
            }else{
                icon = UIImage.image(named: "credit-card")
            }
            let paymentOption = availablePayments[selectedPaymentOptionIndex]
            updatePaymentBtn(title: paymentOption.title, img: icon)
        }
    }
    
    //MARK:- Getters
    public func getPaymentInfo() -> PaymentInfo{
        let paymentInfo = PaymentInfo(method: .cash, cardId: nil)
        if selectedPaymentOptionIndex == 1{
            paymentInfo.mehtod = .wallet
        }else if selectedPaymentOptionIndex > 1{
            paymentInfo.mehtod = .card
            paymentInfo.cardId = availablePayments[selectedPaymentOptionIndex].id
        }
        return paymentInfo
    }
    
    public func getRideCapcity() -> RideCapacity {
        return capacity
    }
    
    public func isMehramRide() -> Bool{
        return mehramView.state
    }
    
    public func getRideOptions() -> RideOptions {
        let options = RideOptions()
        options.isMehram = isMehramRide()
        options.capacity = getRideCapcity()
        options.paymentInfo = getPaymentInfo()
        return options
    }

}
