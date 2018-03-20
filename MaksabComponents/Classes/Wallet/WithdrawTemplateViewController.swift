//
//  WithdrawTemplateViewController.swift
//  MaksabComponents
//
//  Created by Mansoor Ali on 05/01/2018.
//

import UIKit
import StylingBoilerPlate

open class WithdrawTemplateViewController: UIViewController {

    @IBOutlet weak public var fundsAvailable: UILabel!
    @IBOutlet weak public var amountAvailable: UILabel!
    
    @IBOutlet weak public var amountToWithdraw: UILabel!
    @IBOutlet weak public var fieldWithdrawAmount: UITextField!
    @IBOutlet weak var amountInfoMsg: UILabel!
    
    
    @IBOutlet weak public var accountInfo: UILabel!
    @IBOutlet weak public var accountTitle: UITextField!
    @IBOutlet weak public var accountNo: UITextField!
    @IBOutlet weak public var bankName: UITextField!
    @IBOutlet weak public var branchName: UITextField!
    
    @IBOutlet weak public var btnSubmitt: PrimaryButton!
    
    var currentBalance: Double?
    
    override open func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        customize()
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationItem.title = Bundle.localizedStringFor(key: "wallet-withdrawl-nav-title")
    }
    
    func customize()  {
        self.view.backgroundColor = UIColor.appColor(color: .Dark)
        
        fundsAvailable.text = Bundle.localizedStringFor(key: "wallet-withdrawl-funds-available")
        
        amountToWithdraw.text = Bundle.localizedStringFor(key: "wallet-withdrawl-amount-to-withdraw")
        fieldWithdrawAmount.placeholder = Bundle.localizedStringFor(key: "wallet-withdrawl-amount")
        amountInfoMsg.font = UIFont.appFont(font: .RubikRegular, pontSize: 10)
        amountInfoMsg.textColor = UIColor.appColor(color: .LightText)
        amountInfoMsg.text = Bundle.localizedStringFor(key: "wallet-withdrawl-amount-note")
        
        accountInfo.text = Bundle.localizedStringFor(key: "wallet-withdrawl-account-info")
        
        accountTitle.placeholder = Bundle.localizedStringFor(key: "wallet-withdrawl-account-title")
        accountNo.placeholder = Bundle.localizedStringFor(key: "wallet-withdrawl-account-no")
        bankName.placeholder = Bundle.localizedStringFor(key: "wallet-withdrawl-bank-name")
        branchName.placeholder = Bundle.localizedStringFor(key: "wallet-withdrawl-branch-name")
        
        btnSubmitt.setTitle(Bundle.localizedStringFor(key: "wallet-withdrawl-submit-withdrawl"), for: .normal)
    }
    
    public func config(amount: Double){
        let amountText = String(format: "%.2f", amount)
        amountAvailable.attributedText = String.boldAttributedString(boldComponent: "\(amountText)",
            otherComponent: "SAR",
            boldFont: UIFont.appFont(font: .RubikBold, pontSize: 32),
            otherfont: UIFont.appFont(font: .RubikRegular, pontSize: 12),
            textColor: UIColor.appColor(color: .LightText),
            boldFirst: false)
        
    }
    
    public func getAccountInfo() -> (accTitle: String, accNo: String, bankName: String, branchName: String, amount: Double)? {
        guard currentBalance != nil else {
            Alert.showMessage(viewController: self, title: Bundle.localizedStringFor(key:"wallet-withdrawl-insufficient-funds-title"), msg: Bundle.localizedStringFor(key:"wallet-withdrawl-insufficient-funds-msg"))
            return nil
        }
        var amount: Double = 0
        var msg = ""
        if let a = Double(fieldWithdrawAmount.text!),amount > 0 , a < currentBalance!{
            amount = a
        }else{
            msg = Bundle.localizedStringFor(key:"wallet-withdrawl-invalid-amount")
            Alert.showMessage(viewController: self, title: "Inavlid Input", msg: msg)
            return nil
        }
        
        if accountTitle.text!.isEmpty{
            msg = Bundle.localizedStringFor(key: "wallet-withdrawl-account-title-required")
        }else if accountNo.text!.count < 10{
            msg = Bundle.localizedStringFor(key: "wallet-withdrawl-invalid-account-no-msg")
        }else if bankName.text!.isEmpty{
            msg = Bundle.localizedStringFor(key: "wallet-withdrawl-bank-name-required")
        }else if branchName.text!.isEmpty{
            msg = Bundle.localizedStringFor(key: "wallet-withdrawl-branch-name-required")
        }
        
        if msg.isEmpty{
            return (accountTitle.text!,accountNo.text!,bankName.text!,branchName.text!,amount)
        }else{
            Alert.showMessage(viewController: self, title: Bundle.localizedStringFor(key: "payment-add-error-invalid-input"), msg: msg)
            return nil
        }
    }
    
    @IBAction func actSubmitt(_ sender: PrimaryButton) {
        requrestWithDrawl()
    }
    
    open func requrestWithDrawl(){}
}

extension WithdrawTemplateViewController: UITextFieldDelegate{
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == accountTitle || textField == bankName || textField == branchName{
            return handleText(field: textField,range: range, string: string)
        }else{
            return handleAccountNo(field: textField,range: range, string: string)
        }
    }
    
    func handleText(field : UITextField, range: NSRange, string: String) -> Bool {
        return !(field.text!.count > 119 && (string.count > range.length))
    }
    
    func handleAccountNo(field : UITextField, range: NSRange, string: String) -> Bool {
        return !(field.text!.count > 14 && (string.count > range.length))
    }
}
