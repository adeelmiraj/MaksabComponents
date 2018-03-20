//
//  TransactionTableViewCell.swift
//  Maksab Driver
//
//  Created by Incubasys on 23/08/2017.
//  Copyright © 2017 Incubasys. All rights reserved.
//

import UIKit
import StylingBoilerPlate

public class TransactionTableViewCell: UITableViewCell, NibLoadableView {

    @IBOutlet weak var transactionId: UILabel!
    @IBOutlet weak var dateTime: UILabel!
    @IBOutlet weak var details: UILabel!
    
    @IBOutlet weak var transactionTypeContainerView: UIView!
    @IBOutlet weak var transactionIdContainerView: UIView!
    
    @IBOutlet weak var transactionTypeIcon: UIImageView!
    @IBOutlet weak var transactionTypeTitle: UILabel!
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor.appColor(color: .Light)
        transactionId.font = UIFont.appFont(font: .RubikMedium, pontSize: 14)
        transactionId.textColor = UIColor.appColor(color: .DarkText)
        details.textColor = UIColor.appColor(color: .DarkText)
        transactionTypeIcon.tintColor = UIColor.appColor(color: .Dark)
    }

    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func config(createdAt: Date?, amount: Double, description: String)  {
        let unitFormat =  Bundle.localizedStringFor(key: "constant-currency-SAR")
        dateTime.text = createdAt?.string(format: "dd/MM/YYYY, hh:mm a") ?? ""
        details.attributedText =
            String.boldAttributedString(
            boldComponent: String(format: unitFormat,amount),
            otherComponent: description,
            boldFont: UIFont.appFont(font: .RubikMedium, pontSize: 17),
            otherfont: UIFont.appFont(font: .RubikRegular, pontSize: 17),
            textColor: UIColor.appColor(color: .DarkText), boldTextColor: UIColor.appColor(color: .Primary))
    }
    

    
    public func showTransactionId(transactionId: Int)  {
        transactionTypeContainerView.isHidden = true
        transactionIdContainerView.isHidden = false
        let text = String(format:Bundle.localizedStringFor(key: "wallet-cell-transaction-id"),transactionId)
//        let attribText = NSMutableAttributedString(string: text)
//        attribText.replacePlaceholder(string: "\(transactionId)", attributes: [NSFontAttributeName: UIFont.appFont(font: .RubikRegular, pontSize: 14),NSForegroundColorAttributeName:UIColor.appColor(color: .LightText)])
        self.transactionId.text = text
//            String.boldAttributedString(
//            boldComponent: "\(transactionId)",
//            otherComponent:  ,
//            boldFont: UIFont.appFont(font: .RubikMedium, pontSize: 14),
//            otherfont: UIFont.appFont(font: .RubikRegular, pontSize: 14),
//            textColor: UIColor.appColor(color: .LightText))
       
    }
    
    public func showTransactionType(title:String, icon: UIImage)  {
        transactionTypeContainerView.isHidden = false
        transactionIdContainerView.isHidden = true
        transactionTypeTitle.text = title
        transactionTypeIcon.image = icon.withRenderingMode(.alwaysTemplate)
    }
}

extension NSMutableAttributedString {
    func replacePlaceholder(string: String, attributes: [String: Any]) {
        
        // find the placeholder
        let range = (string as NSString).range(of: string)
        
        // nothing to replace
        if range.location == NSNotFound {
            return
        }
        
        // replace it with the translation
//        mutableString.replaceCharacters(in: range, with: translation)
        
        // adjust range according to changes
//        range.length = range.length + translation.count - placeholder.count
        
        // apply attributes
        self.setAttributes(attributes, range: range)
    }
}
