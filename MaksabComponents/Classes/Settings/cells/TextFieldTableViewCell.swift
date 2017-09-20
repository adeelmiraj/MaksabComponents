//
//  TextFieldTableViewCell.swift
//  Pods
//
//  Created by Incubasys on 20/09/2017.
//
//

import UIKit
import StylingBoilerPlate

public protocol TextFieldTableViewCellDelegate{
    func textFieldExit(indexPath: IndexPath, text: String)
}
public class TextFieldTableViewCell: UITableViewCell, NibLoadableView, UITextFieldDelegate {

    @IBOutlet weak public var field: UITextField!
    @IBOutlet weak var label: TextLabel!
    
    var delegate: TextFieldTableViewCellDelegate?
    var indexPath: IndexPath?
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configView()
        hideDefaultSeparator()
    }

    func configView()  {
        self.backgroundColor = UIColor.appColor(color: .Dark)
        field.textColor = UIColor.appColor(color: .LightText)
        field.tintColor = UIColor.appColor(color: .Light)
        field.delegate = self
    }
    
    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func config(label: String, placeholder: String,delegate: TextFieldTableViewCellDelegate, indexPath: IndexPath)  {
        self.delegate = delegate
        self.label.text = label
        field.placeholder = placeholder
        self.indexPath = indexPath
    }
    
    //MARK:- UITextFieldDelegate
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let index = indexPath else {
            return true
        }
        delegate?.textFieldExit(indexPath: index, text: textField.text ?? "")
        textField.resignFirstResponder()
        return true
    }
    
}
