//
//  PhoneNumberAlertViewController.swift
//  Pods
//
//  Created by Incubasys on 31/07/2017.
//
//

import UIKit
import StylingBoilerPlate

open class PhoneNumberAlertTemplateViewController: UIViewController, NibLoadableView {
    
    @IBOutlet weak public var labelTitle: TitleLabel!
    @IBOutlet weak public var labelDescription: TextLabel!
    @IBOutlet weak public var fieldPhoneNumber: UITextField!
    @IBOutlet weak public var fieldPhoneCode: UITextField!
    @IBOutlet weak public var btnCancel: UIButton!
    @IBOutlet weak public var btnRegister: UIButton!
    @IBOutlet weak public var errorLbl: UILabel!
    
    
    let bundle = Bundle(for: PhoneNumberAlertTemplateViewController.classForCoder())
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        
        labelTitle.text = Bundle.localizedStringFor(key: "phone-no-required")
        labelDescription.text = Bundle.localizedStringFor(key: "phone-no-required-description")
        btnCancel.setTitle(Bundle.localizedStringFor(key: "alert-action-Cancel"), for: .normal)
        btnRegister.setTitle(Bundle.localizedStringFor(key: "phone-no-register"), for: .normal)
        fieldPhoneNumber.placeholder = Bundle.localizedStringFor(key: "phone-no-enter-number")
        fieldPhoneCode.text = Bundle.localizedStringFor(key: "phone-no-country-code")
        errorLbl.textColor = UIColor.appColor(color: .Destructive)
        errorLbl.font = UIFont.appFont(font: .RubikRegular, pontSize: 10)
        fieldPhoneNumber.delegate = self
        fieldPhoneCode.delegate = self
        fieldPhoneCode.clearButtonMode = .never
        fieldPhoneNumber.becomeFirstResponder()
    }

    @IBAction func actionCancel(_ sender: Any) {
        self.view.endEditing(true)
        cancelTapped()
    }
    
    func cancelTapped(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func actionRegister(_ sender: UIButton) {
        
        guard let phoneNo = getPhoneNo() else {
            errorLbl.text = Bundle.localizedStringFor(key: "phone-no-must-be-twelve-digits")
            fieldPhoneCode.shake()
            fieldPhoneNumber.shake()
            return
        }
        self.view.endEditing(true)
        
        registerTapped(phoneNo: phoneNo)
    }
    
    open func registerTapped(phoneNo: String){}
    
    public func getPhoneNo() -> String? {
        return RegisterationTemplateViewController.getValidPhoneNoFrom(fieldCode: fieldPhoneCode, fieldPhoneNo: fieldPhoneNumber)
    }
}

extension PhoneNumberAlertTemplateViewController: UITextFieldDelegate{
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        errorLbl.text = ""
        if textField == fieldPhoneCode{
            return RegisterationTemplateViewController.handlePhoneCode(textField: textField, shouldChangeCharactersIn: range, replacementString: string)
        }else{
            return RegisterationTemplateViewController.handlePhoneNumber(textField: textField, shouldChangeCharactersIn: range, replacementString: string)
        }
    }
}
