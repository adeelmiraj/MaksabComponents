//
//  DeliveryItemTableViewCell.swift
//  Pods
//
//  Created by Incubasys on 10/08/2017.
//
//

import UIKit
import StylingBoilerPlate

public protocol DeliveryItemCellDelegate{
    func removeCell(atIndexPath: IndexPath)
    func deliveryItemNameChanged(atIndexPath: IndexPath, itemName: String)
    func deliveryItemQtyChanged(atIndexPath: IndexPath, qty: Int)
}

public class DeliveryItemTableViewCell: UITableViewCell, NibLoadableView, UITextFieldDelegate{

    @IBOutlet weak public var fieldItemName: UITextField!
    @IBOutlet weak public var fieldQty: UITextField!
    @IBOutlet weak var btnRemove: UIButton!
    
    public var indexPath: IndexPath?
    public var delegate: DeliveryItemCellDelegate?
//    let bundle = Bundle(for: DeliveryItemTableViewCell.classForCoder())
    let bh = BundleHelper(resourceName: Constants.resourceName)
    public var tableView: UITableView?
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        fieldItemName.placeholder = "Item Name"
        fieldQty.placeholder = "Quantity"
        
        fieldItemName.returnKeyType = .done
        fieldQty.returnKeyType = .done
        
        fieldItemName.delegate = self
        fieldQty.delegate = self
        
        btnRemove.backgroundColor = UIColor.appColor(color: .Secondary)
        btnRemove.layer.cornerRadius = btnRemove.frame.size.height / 2
        
        let img = bh.getImageFromMaksabComponent(name: "cross", _class: DeliveryItemTableViewCell.self)
//        img =  UIImage.scaleImage(image: img, width: 8)
        btnRemove.setImage(img, for: .normal)
//        btnRemove.setImage(img.imageWithColor(color1: img), for: .normal)
        btnRemove.tintColor = UIColor.appColor(color: .Light)
    }

    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func actRemove(_ sender: UIButton) {
        guard let index = indexPath else{
            return
        }
        delegate?.removeCell(atIndexPath: index)
    }
    
    public func config(deliveryItem: DeliveryItem){
        fieldItemName.text = deliveryItem.itemName
        if deliveryItem.quantity <= 0{
            fieldQty.text = ""
        }else{
            fieldQty.text = "\(deliveryItem.quantity)"
        }
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        tableView?.isScrollEnabled = false
        return true
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        tableView?.isScrollEnabled = true
    }
    
    @IBAction func actItemNameChanged(_ sender: UITextField) {
        let rows = tableView?.numberOfRows(inSection: 0) ?? 0
        if rows == 1 && sender.text!.isEmpty && fieldQty.text!.isEmpty{
            btnRemove.isHidden = true
        }else if rows > 1 || !sender.text!.isEmpty{
            btnRemove.isHidden = false
        }
        
        guard let index = indexPath else {
            return
        }
        
        delegate?.deliveryItemNameChanged(atIndexPath: index, itemName: sender.text ?? "")
        
    }
    
    @IBAction func actQtyChanged(_ sender: UITextField) {
        
        let rows = tableView?.numberOfRows(inSection: 0) ?? 0
        if rows == 1 && sender.text!.isEmpty && fieldItemName.text!.isEmpty{
            btnRemove.isHidden = true
        }else if rows > 1 || !sender.text!.isEmpty{
            btnRemove.isHidden = false
        }
        
        guard let index = indexPath else {
            return
        }
        
        guard let qty = Int(sender.text ?? "0") else {
            return
        }
        
        
        delegate?.deliveryItemQtyChanged(atIndexPath: index, qty: qty)
    }
    
    public func hideDeleteButton(){
        btnRemove.isHidden = true
    }
    
    public func showDeleteButton(){
        btnRemove.isHidden = false
    }
}
