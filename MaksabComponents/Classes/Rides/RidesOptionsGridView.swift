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
            return "payment-method-Credit".localized(bundle: .main)
        case .cash:
            return "payment-method-Cash".localized(bundle: .main)
        case .wallet:
            return "payment-method-Maqsab Wallet".localized(bundle: .main)
        }
    }
}

public enum RideCapacity: Int {
    case twoSitter = 0
    case fiveSitter = 1
    case sevenSitter = 2
    
    public func getCount() -> Int {
        switch self {
        case .twoSitter:
            return 2
        case .fiveSitter:
            return 5
        case .sevenSitter:
            return 7
        }
    }
}

public class RideOptions{
    public var isMehram: Bool = false
    public var isSmoking: Bool = false
    public var capacity: RideCapacity = .twoSitter
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
        let optionCash = PaymentOptions(title: "Cash", id: -1)
        let optionWallet = PaymentOptions(title: "Wallet", id: -1)
        return [optionCash,optionWallet]
    }
}

public class RidesOptionsGridView: UIView, CustomView, NibLoadableView, Toggleable{
    
    
    static public func createInstance(x: CGFloat, y: CGFloat, width:CGFloat) -> RidesOptionsGridView{
        let inst = RidesOptionsGridView(frame: CGRect(x: x, y: y, width: width, height: 139))
        return inst
    }
    
    let bundle = Bundle(for: RidesOptionsGridView.classForCoder())
    
    @IBOutlet weak public var btnMehramRide: ToggleButton!
    @IBOutlet weak var btnNoSmoking: ToggleButton!
    @IBOutlet weak public var btnPayment: ToggleButton!
    @IBOutlet weak public var btnNoOfPassegners: ToggleButton!
    
    var view: UIView!
    var capacity = RideCapacity.twoSitter
    var availablePayments = PaymentOptions.createPaymentOptions()
    var selectedPaymentOptionIndex: Int = 0
    
    let bh = BundleHelper(resourceName: Constants.resourceName)
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
        let icon = bh.getImageFromMaksabComponent(name: "cash-circle", _class: RidesOptionsGridView.self)
        updatePaymentBtn(title: availablePayments[selectedPaymentOptionIndex].title, img: icon)
        btnNoOfPassegners.setTitle("\(capacity.getCount()) or less Passengers", for: .normal)
        
        btnMehramRide.toggleDelegate = self
        btnNoSmoking.toggleDelegate = self
        btnPayment.toggleDelegate = self
        btnNoOfPassegners.toggleDelegate = self
    }
    
    public func addCreditCards(creditCards: [PaymentOptions]){
        availablePayments.append(contentsOf: creditCards)
    }
    
    //MARK:- Setters
    public func config(rideOptions: RideOptions){
        btnMehramRide.stateSelected = rideOptions.isMehram
        setSmoking(state: rideOptions.isSmoking)
        setCapacity(capacity: rideOptions.capacity)
        setPayment(paymentInfo: rideOptions.paymentInfo)
    }
    
    //Smoking
    public func setSmoking(state: Bool)  {
        if state{
            btnNoSmoking.setTitle("Smoking", for: .normal)
        }else{
            btnNoSmoking.setTitle("No Smoking", for: .normal)
        }
        btnNoSmoking.stateSelected = state
    }
    
    //Capacity
    public func setCapacity(capacity: RideCapacity)  {
        self.capacity = capacity
        btnNoOfPassegners.setTitle("\(capacity.getCount()) or less Passengers", for: .normal)
    }
    
    //Payment
    public func setPayment(paymentInfo: PaymentInfo){
        var icon: UIImage!
        switch paymentInfo.mehtod {
        case .cash:
            selectedPaymentOptionIndex = 0
            icon = bh.getImageFromMaksabComponent(name: "cash-circle", _class: RidesOptionsGridView.self)
        case .wallet:
            selectedPaymentOptionIndex = 1
            icon = bh.getImageFromMaksabComponent(name: "wallet-card", _class: RidesOptionsGridView.self)
        case .card:
            if let cardIndex = getIndexForCard(id: paymentInfo.cardId){
                selectedPaymentOptionIndex = cardIndex
                icon = bh.getImageFromMaksabComponent(name: "credit-card", _class: RidesOptionsGridView.self)
            }else{
                selectedPaymentOptionIndex = 0
                icon = bh.getImageFromMaksabComponent(name: "cash-circle", _class: RidesOptionsGridView.self)
            }
        }
        updatePaymentBtn(title: availablePayments[selectedPaymentOptionIndex].title, img: icon)
    }
    
    func updatePaymentBtn(title: String, img: UIImage)  {
        btnPayment.setTitle(title, for: .normal)
        btnPayment.setImage(img.withRenderingMode(.alwaysOriginal), for: .normal)
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
    
    public func onToggle(stateSelected: Bool, sender: UIButton) {
        let btn = sender as! ToggleButton
       
        if btn == btnNoSmoking{
            setSmoking(state: btn.stateSelected)
        }else if btn == btnPayment{
            if selectedPaymentOptionIndex == availablePayments.count - 1{
                selectedPaymentOptionIndex = 0
            }else{
                selectedPaymentOptionIndex += 1
            }
            var icon: UIImage!
            if selectedPaymentOptionIndex == 0{
                 icon = bh.getImageFromMaksabComponent(name: "cash-circle", _class: RidesOptionsGridView.self)
            }else if selectedPaymentOptionIndex == 1{
                 icon = bh.getImageFromMaksabComponent(name: "wallet-card", _class: RidesOptionsGridView.self)
            }else{
                 icon = bh.getImageFromMaksabComponent(name: "credit-card", _class: RidesOptionsGridView.self)
            }
            let paymentOption = availablePayments[selectedPaymentOptionIndex]
            updatePaymentBtn(title: paymentOption.title, img: icon)
        }else if btn == btnNoOfPassegners{
            switch capacity {
            case .twoSitter:
                self.capacity = .fiveSitter
            case .fiveSitter:
                self.capacity = .sevenSitter
            case .sevenSitter:
                self.capacity = .twoSitter
            }
            setCapacity(capacity: capacity)
        }
    }
    

    /*
    public func isCash() -> Bool{
      return selectedPaymentOptionIndex == 0
    }
    
    public func isWallet() -> Bool{
        return selectedPaymentOptionIndex == 1
    }
    
    public func getCreditCardId() -> Int{
        return availablePayments[selectedPaymentOptionIndex].id
    }*/
    
    //MARK:- Getters
    public func getPaymentInfo() -> PaymentInfo{
        var paymentInfo = PaymentInfo(method: .cash, cardId: nil)
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
    
    public func isSmoking() -> Bool{
        return btnNoSmoking.stateSelected
    }
    
    public func isMehramRide() -> Bool{
        return btnMehramRide.stateSelected
    }
    
    public func getRideOptions() -> RideOptions {
        let options = RideOptions()
        options.isMehram = isMehramRide()
        options.isSmoking = isSmoking()
        options.capacity = getRideCapcity()
        options.paymentInfo = getPaymentInfo()
        return options
    }

}
