//
//  AddPaymentMethodView.swift
//  Pods
//
//  Created by Incubasys on 15/08/2017.
//
//

import UIKit
import StylingBoilerPlate

public class PaymentCardView: UIView, CustomView, NibLoadableView, UITextFieldDelegate {

    @IBOutlet weak var staticLabelCardNo: UILabel!
    @IBOutlet weak var staticLabelExpiryDate: UILabel!
    @IBOutlet weak var staticLabelCvv: UILabel!
    @IBOutlet weak var staticLabelCardHolderName: UILabel!
    
   
    @IBOutlet weak var cardImg: UIImageView!
    @IBOutlet weak var fieldCardNo: UITextField!
    @IBOutlet weak var fieldExpiryDate: UITextField!
    @IBOutlet weak var fieldCvv: UITextField!
    @IBOutlet weak var fieldCardHolderName: UITextField!
  
    let bundle = Bundle(for: PaymentCardView.classForCoder())
    var view: UIView!
    public static let height: CGFloat = 188+16
    
    public struct PaymentCardInfo{
        public var cardNo: String
        public var expiryDate: String
        public var cvv: String
        public var cardHolderName: String
        public var expiryYear: Int = 0
        public var expiryMonth: Int = 0
        
        public init(cardNo: String, expiryDate: String, cvv: String, cardHolderName: String) {
            self.cardNo = cardNo
            self.expiryDate = expiryDate
            self.cvv = cvv
            self.cardHolderName = cardHolderName
        }
    }
    
    static public func createInstance(x: CGFloat, y: CGFloat = 0, width: CGFloat) -> PaymentCardView{
        let inst = PaymentCardView(frame: CGRect(x: x, y: y, width: width, height: PaymentCardView.height))
        return inst
    }
    
    override required public init(frame: CGRect) {
        super.init(frame: frame)
        let bundle = Bundle(for: type(of: self))
        view = self.commonInit(bundle: bundle)
        configView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let bundle = Bundle(for: type(of: self))
        view = self.commonInit(bundle: bundle)
        configView()
    }
    

    func configView()  {
        let color = UIColor(netHex: 0x777777)
        staticLabelCardNo.text = "CARD NUMBER"
        staticLabelCardNo.textColor = color
        staticLabelExpiryDate.text = "EXPIRATION DATE"
        staticLabelExpiryDate.textColor = color
        staticLabelCvv.text = "CVV"
        staticLabelCvv.textColor = color
        staticLabelCardHolderName.text = "CARDHOLDER NAME"
        staticLabelCardHolderName.textColor = color
        
        fieldCardNo.placeholder = "0000 0000 0000 0000"
        fieldExpiryDate.placeholder = "MM/YY"
        fieldCvv.placeholder = "1234"
        fieldCardHolderName.placeholder = "ABC"
        
        fieldCardNo.delegate = self
        fieldExpiryDate.delegate = self
        fieldCvv.delegate = self
        fieldCardHolderName.delegate = self
    }
    
    public func getCardInfo(completion:@escaping((_ err:ResponseError?,_ cardInfo: PaymentCardInfo?)->Void)){
        
        let err = ResponseError()
        err.errorTitle = "Invalid Input"
        err.reason = ""
        
        //        if deliveryItems.count == 1 && deliveryItems[0].itemName.isEmpty && deliveryItems[0].quantity < 0{
        //            err.reason = "Please enter valid name and quantity."
        //
        //        }
        if fieldCardNo.text!.characters.count != 19{
            err.reason = "Card no must have 16 digits"
        }else if fieldExpiryDate.text!.characters.count != 5{
            err.reason = "Invalid expiry date"
        }else if fieldCvv.text!.characters.count < 3 {
            err.reason = "Invalid CVV"
        }else if fieldCardHolderName.text!.isEmpty{
            err.reason = "Card Holder name is required"
        }
        
        var cardInfo = PaymentCardInfo(cardNo: fieldCardNo.text!, expiryDate: fieldExpiryDate.text!, cvv: fieldCvv.text!, cardHolderName: fieldCardHolderName.text!)
        
        let expDate = fieldExpiryDate.text!
        let yearStr = expDate.substring(from: expDate.index(expDate.startIndex, offsetBy: 3))
        let monthStr = expDate.substring(to: expDate.index(expDate.startIndex, offsetBy: 2))
        if let year = Int(yearStr){
            cardInfo.expiryYear = year
        }else{
            err.reason = "Invalid expiry Date"
        }
        if let month = Int(monthStr),month <= 12, month >= 1 {
            cardInfo.expiryMonth = month
        }else{
            err.reason = "Invalid expiry Date"
        }
        
        

        if err.reason.isEmpty{
            completion(nil, cardInfo)
        }else{
            completion(err, nil)
        }
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == fieldCardNo{
            return handleCardInput(textField: textField, shouldChangeCharactersInRange: range, replacementString: string)
        }else if textField == fieldCvv{
            return handleCvvInput(textField: textField, shouldChangeCharactersInRange: range, replacementString: string)
        }else if textField == fieldExpiryDate{
            return handleDateInput(textField: textField, shouldChangeCharactersInRange: range, replacementString: string)
        }
        return true
    }
    
    
    func handleCardInput(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        // check the chars length dd -->2 at the same time calculate the dd-MM --> 5
        if textField.text!.isEmpty{
            if let num = Int(string){
                setCardImage(firstDigit: num)
            }
        }else{
            cardImg.image = nil
        }
        
        if (textField.text!.characters.count == 4) || (textField.text!.characters.count == 9 ) || (textField.text!.characters.count == 14) {
            //Handle backspace being pressed
            if !(string == "") {
                // append the text
                textField.text = textField.text! + " "
            }
        }
        return !(textField.text!.characters.count > 18 && (string.characters.count ) > range.length)
    }
    
    func setCardImage(firstDigit:Int)  {
        let bh = BundleHelper(resourceName: Constants.resourceName)
        if firstDigit == 5{
            cardImg.image = bh.getImageFromMaksabComponent(name: "master-card", _class: PaymentCardView.self)
        }else if firstDigit == 3{
            cardImg.image = bh.getImageFromMaksabComponent(name: "master-card", _class: PaymentCardView.self)
        }else{
            cardImg.image = bh.getImageFromMaksabComponent(name: "master-card", _class: PaymentCardView.self)
        }
    }
    
    func handleDateInput(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        // check the chars length dd -->2 at the same time calculate the dd-MM --> 5
        //        || (textField.text!.characters.count == 5)
        if (textField.text!.characters.count == 2)  {
            //Handle backspace being pressed
            if !(string == "") {
                // append the text
                textField.text = textField.text! + "/"
            }
        }
        // check the condition not exceed 9 chars
        return !(textField.text!.characters.count > 4 && (string.characters.count ) > range.length)
    }
    
    func handleCvvInput(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let newLength = textField.text!.characters.count + string.characters.count - range.length
//        let newString = NSString(string: textField.text!).replacingCharacters(in: range, with: string)
//        if newString.characters.count == 5 {
//            textField.rightView = UIImageView(image: #imageLiteral(resourceName: "smallGreenTick"))
//        }else{
//            textField.rightView = UIImageView(image: nil)
//        }
        return newLength <= 4
    }
    

}
