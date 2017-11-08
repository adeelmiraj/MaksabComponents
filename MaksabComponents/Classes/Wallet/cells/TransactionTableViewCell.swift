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

    @IBOutlet weak public var staticLabelTransactionId: UILabel!
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
        self.backgroundColor = UIColor.appColor(color: .Dark)
        transactionId.font = UIFont.appFont(font: .RubikMedium, pontSize: 14)
        transactionId.textColor = UIColor.appColor(color: .LightText)
        details.textColor = UIColor.appColor(color: .LightText)
        transactionTypeIcon.tintColor = UIColor.appColor(color: .Light)
        
        staticLabelTransactionId.text = Bundle.localizedStringFor(key: "wallet-cell-transaction-id")
       
    }

    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func config(createdAt: Date?, amount: Double, description: String)  {
        let unit =  Bundle.localizedStringFor(key: "constant-currency-SAR")
        dateTime.text = createdAt?.string(format: "dd/MM/YYYY, hh:mm a") ?? ""
        details.attributedText = String.boldAttributedString(
            boldComponent: String(format:"\(unit) %.2f",amount),
            otherComponent: description,
            boldFont: UIFont.appFont(font: .RubikMedium, pontSize: 17),
            otherfont: UIFont.appFont(font: .RubikRegular, pontSize: 17),
            textColor: UIColor.appColor(color: .LightText))
    }
    

    
    public func showTransactionId(transactionId: String)  {
        transactionTypeContainerView.isHidden = true
        transactionIdContainerView.isHidden = false
        self.transactionId.text = transactionId
    }
    
    public func showTransactionType(title:String, icon: UIImage)  {
        transactionTypeContainerView.isHidden = false
        transactionIdContainerView.isHidden = true
        transactionTypeTitle.text = title
        transactionTypeIcon.image = icon.withRenderingMode(.alwaysTemplate)
    }
}
