//
//  AddPaymentMethodView.swift
//  Pods
//
//  Created by Incubasys on 15/08/2017.
//
//

import UIKit
import StylingBoilerPlate

public struct PaymentCardInfo{
    public var title: String
    public var cardNo: String
    public var expiryDate: String
    public var cvv: String
    public var cardHolderName: String
    public var expiryYear: Int = 0
    public var expiryMonth: Int = 0
    
    public init(title: String, cardNo: String, expiryDate: String, cvv: String, cardHolderName: String) {
        self.title = title
        self.cardNo = cardNo
        self.expiryDate = expiryDate
        self.cvv = cvv
        self.cardHolderName = cardHolderName
    }
    
    public func encodeToJSON() -> [String:Any] {
        var dictionary = [String:Any]()
        dictionary["name"] = cardHolderName
        dictionary["number"] = cardNo
        dictionary["exp_month"] = expiryMonth
        dictionary["exp_year"] = expiryYear
        dictionary["cvc"] = cvv
        return dictionary
    }
}

public class PaymentCardView: UIView, CustomView, NibLoadableView, UITextFieldDelegate {

    @IBOutlet weak public var staticLabelCardNo: UILabel!
    @IBOutlet weak public var staticLabelExpiryDate: UILabel!
    @IBOutlet weak public var staticLabelCvv: UILabel!
    @IBOutlet weak public var staticLabelCardHolderName: UILabel!
    
   
    @IBOutlet weak var cardImg: UIImageView!
    @IBOutlet weak public var fieldTitle: UITextField!
    @IBOutlet weak public var fieldCardNo: UITextField!
    @IBOutlet weak public var fieldExpiryDate: UITextField!
    @IBOutlet weak public var fieldCvv: UITextField!
    @IBOutlet weak public var fieldCardHolderName: UITextField!
  
    let bundle = Bundle(for: PaymentCardView.classForCoder())
    var view: UIView!
    public static let height: CGFloat = 277
//        188+16
    public var errors = [String]()
    public var errorTitle = String()
    
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
        backgroundColor = UIColor.appColor(color: .Light)
        let color = UIColor(netHex: 0x777777)
        
        staticLabelCardNo.textColor = color
        staticLabelExpiryDate.textColor = color
        staticLabelCvv.textColor = color
        staticLabelCardHolderName.textColor = color
        
        fieldTitle.font = UIFont.appFont(font: .RubikMedium, pontSize: 17)
        
        fieldCardNo.delegate = self
        fieldExpiryDate.delegate = self
        fieldCvv.delegate = self
        fieldCardHolderName.delegate = self
        
        staticLabelCardNo.text = Bundle.localizedStringFor(key: "payment-add-card-no")
        staticLabelExpiryDate.text = Bundle.localizedStringFor(key: "payment-add-expiry-date")
        staticLabelCvv.text = Bundle.localizedStringFor(key: "payment-add-cvv")
        staticLabelCardHolderName.text = Bundle.localizedStringFor(key: "payment-add-carholder-name")
        
        fieldTitle.attributedPlaceholder = NSAttributedString(string: Bundle.localizedStringFor(key: "constant-title"), attributes: [NSFontAttributeName: UIFont.appFont(font: .RubikMedium, pontSize: 17)])
        fieldTitle.font = UIFont.appFont(font: .RubikMedium, pontSize: 17)
        
        fieldCardNo.placeholder = Bundle.localizedStringFor(key: "payment-add-cardno-placeholder")
        fieldExpiryDate.placeholder = Bundle.localizedStringFor(key: "payment-add-date-placeholder")
        fieldCvv.placeholder = Bundle.localizedStringFor(key: "payment-add-fieldcvv-placeholder")
        fieldCardHolderName.placeholder = Bundle.localizedStringFor(key: "payment-add-field-cardno-placeholder")
        
        errorTitle = Bundle.localizedStringFor(key: "payment-add-error-invalid-input")
        errors = [String]()
        errors.append(Bundle.localizedStringFor(key: "payment-add-eror-title-req"))
        errors.append(Bundle.localizedStringFor(key: "payment-add-eror-invalid-card-no"))
        errors.append(Bundle.localizedStringFor(key: "payment-add-eror-invalid-expiry-date"))
        errors.append(Bundle.localizedStringFor(key: "payment-add-eror-invalid-cvv"))
        errors.append(Bundle.localizedStringFor(key: "payment-add-eror-invalid-cardholder-name"))
    }
    
    public func getCardInfo(completion:@escaping((_ err:ResponseError?,_ cardInfo: PaymentCardInfo?)->Void)){
        
        let err = ResponseError()
        err.errorTitle = errorTitle
        err.reason = ""
        
        //        if deliveryItems.count == 1 && deliveryItems[0].itemName.isEmpty && deliveryItems[0].quantity < 0{
        //            err.reason = "Please enter valid name and quantity."
        //
        //        }
        if fieldTitle.text!.isEmpty{
            err.reason = errors[0]
        }else if fieldCardNo.text!.count != 19{
            err.reason = errors[1]
        }else if fieldExpiryDate.text!.count != 5{
            err.reason = errors[2]
        }else if fieldCvv.text!.count < 3 {
            err.reason = errors[3]
        }else if fieldCardHolderName.text!.isEmpty{
            err.reason = errors[4]
        }
        
        var cardInfo = PaymentCardInfo(title: fieldTitle.text!, cardNo: fieldCardNo.text!, expiryDate: fieldExpiryDate.text!, cvv: fieldCvv.text!, cardHolderName: fieldCardHolderName.text!)
        
        guard  !fieldExpiryDate.text!.isEmpty  else {
            err.errorTitle = errorTitle
            err.reason = errors[2]
            completion(err, nil)
            return
        }
        let expDate = fieldExpiryDate.text!
        let yearStr = expDate.substring(from: expDate.index(expDate.startIndex, offsetBy: 3))
        let monthStr = expDate.substring(to: expDate.index(expDate.startIndex, offsetBy: 2))
        if let year = Int("20\(yearStr)"){
            cardInfo.expiryYear = year
        }else{
            err.reason = errors[0]
        }
        if let month = Int(monthStr),month <= 12, month >= 1 {
            cardInfo.expiryMonth = month
        }else{
            err.reason = errors[0]
        }
        
        if err.reason.isEmpty{
            cardInfo.cardNo = cardInfo.cardNo.replacingOccurrences(of: " ", with: "")
            completion(nil, cardInfo)
        }else{
            completion(err, nil)
        }
    }
    
    
    func handleCardInput(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        // check the chars length dd -->2 at the same time calculate the dd-MM --> 5
        let replaced = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        setCardImage(string: replaced)
        if (textField.text!.count == 4) || (textField.text!.count == 9 ) || (textField.text!.count == 14) {
            //Handle backspace being pressed
            if !(string == "") {
                // append the text
                textField.text = textField.text! + " "
            }
        }
        return !(textField.text!.count > 18 && (string.count ) > range.length)
    }
    
    func setCardImage(string: String)  {
        let bh = BundleHelper(resourceName: Constants.resourceName)
        
//        if string.count == 1 , let digit = Int(string), digit == 4{
//
//        }else{
//            cardImg.image = bh.getImageFromMaksabComponent(name: "creditcard", _class: PaymentCardView.self)
//        }
        
        guard string.count <= 2 , let digit = Int(string) else {
            return
        }
        
        if digit == 4 || (digit >= 40 && digit <= 49){
            //first digit 4 visa
            cardImg.setImg(named: "visacard")
        }else if digit >= 51 && digit <= 55{
            //first two digits 5x  x can be 1-5 matercard
            cardImg.setImg(named: "mastercard")
        }else if digit == 34 || digit == 37{
            //first two digits 34  or 37 american express
            cardImg.setImg(named: "americanexpersscard")
        }else{
            cardImg.image = nil
        }
    }
    
    func handleDateInput(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        // check the chars length dd -->2 at the same time calculate the dd-MM --> 5
        //        || (textField.text!.characters.count == 5)
        if (textField.text!.count == 2)  {
            //Handle backspace being pressed
            if !(string == "") {
                // append the text
                textField.text = textField.text! + "/"
            }
        }
        // check the condition not exceed 9 chars
        return !(textField.text!.count > 4 && (string.count ) > range.length)
    }
    
    func handleCvvInput(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let newLength = textField.text!.count + string.count - range.length
//        let newString = NSString(string: textField.text!).replacingCharacters(in: range, with: string)
//        if newString.characters.count == 5 {
//            textField.rightView = UIImageView(image: #imageLiteral(resourceName: "smallGreenTick"))
//        }else{
//            textField.rightView = UIImageView(image: nil)
//        }
        return newLength <= 4
    }
    

}
