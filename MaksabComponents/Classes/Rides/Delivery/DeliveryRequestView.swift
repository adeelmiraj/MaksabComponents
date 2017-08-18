//
//  DeliveryRequestView.swift
//  Pods
//
//  Created by Incubasys on 10/08/2017.
//
//

import UIKit
import StylingBoilerPlate

public protocol DeliveryRequestViewDelegate{
    func requestDelivery()
    func addNewRow()
}

public struct DeliveryItem{
    public var itemName: String = ""
    public var quantity: Int = 0
    
    public init() {}
    
    public init(itemName: String, qty: Int){
        self.init()
        self.itemName = itemName
        self.quantity = qty
    }
}
public class DeliveryRequestView: UIView, CustomView, NibLoadableView, SlidableView {
    
    public static let height: CGFloat = 350
    let bundle = Bundle(for: DeliveryRequestView.classForCoder())
    
    @IBOutlet weak var labelDelivery: UILabel!
    @IBOutlet weak var deliveryPhoto: UIImageView!
    @IBOutlet weak var btnRequestDelivery: PrimaryButton!
    @IBOutlet weak public var tableView: UITableView!
    
    
    
    var contentView: UIView!
//    public var tableView: UITableView!
    var delegate: DeliveryRequestViewDelegate?
    
    let bh = BundleHelper(resourceName: Constants.resourceName)
    
    static public func createInstance(x: CGFloat, y: CGFloat = UIScreen.main.bounds.height - DeliveryRequestView.height, width: CGFloat, delegate: DeliveryRequestViewDelegate) -> DeliveryRequestView{
        let inst = DeliveryRequestView(frame: CGRect(x: x, y: y, width: width, height: DeliveryRequestView.height))
        inst.delegate = delegate
        return inst
    }
    
    
    public override required init(frame: CGRect) {
        super.init(frame: frame)
        contentView = commonInit(bundle: bundle)
        configView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        contentView = commonInit(bundle: bundle)
        configView()
    }
    
    func configView()  {
        labelDelivery.text = "Delivery"
        deliveryPhoto.image = bh.getImageFromMaksabComponent(name: "delivery-borderless", _class: DeliveryRequestView.self)
        
        btnRequestDelivery.setTitle("Request Delivery", for: .normal)
        
        tableView.rowHeight = 64
        tableView.register(DeliveryItemTableViewCell.self, bundle: bundle)
        tableView.tableFooterView = createFooterView()
        self.hide(animated: false)
    }
    
    func createFooterView() -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 70))
        let x = (UIScreen.main.bounds.width/2) - (160/2)
        let y = (view.frame.size.height/2) - (36/2)
        let btn = DashedBorderButton(type: .system)
        btn.frame = CGRect(x: x, y: y, width: 160, height: 36)
        btn.config()
        btn.setTitle("Add Item", for: .normal)
        btn.isUserInteractionEnabled = true
        btn.addTarget(self, action: #selector(addRow), for: .touchUpInside)
        view.addSubview(btn)
        return view
    }
    
    func addRow()  {
        delegate?.addNewRow()
    }
    
    @IBAction func actRequestDelivery(){
       delegate?.requestDelivery()
    }
    
    public func incrementTableHeight(by:CGFloat = 64)  {
        let f = self.frame
        let y = UIScreen.main.bounds.height - (f.size.height+by)
        if y >= 44{
            self.frame = CGRect(x: f.origin.x, y: y, width: f.size.width, height: f.size.height + by)
        }
    }
    
    public func addRows(atIndexPaths: [IndexPath], addItemsToData:@escaping ((_ indexPaths: [IndexPath])->Void), noOfItemsInData:@escaping(()->Int)){
        incrementTableHeight()
        addItemsToData(atIndexPaths)
        tableView.beginUpdates()
        tableView.insertRows(at: atIndexPaths, with: .top)
        tableView.endUpdates()
        let height = tableView.contentSize.height - tableView.frame.size.height
        let dataItemsCount = noOfItemsInData()
        if dataItemsCount > 0 && height > 0{
            let i = IndexPath(row: dataItemsCount-1, section: 0)
//            tableView.scrollRectToVisible(CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: tableView.contentSize.width, height: tableView.contentSize.height+70)), animated: true)
            tableView.scrollToRow(at: i, at: .bottom, animated: true)
        }
        //        tableView.reloadData()
    }

    public func decrementTableHeight(by:CGFloat = 64)  {
        let f = self.frame
        let height = (tableView.contentSize.height-8) - (tableView.frame.size.height-by)
        print(height)
        if f.size.height > DeliveryRequestView.height && height <= 0{
            let y = UIScreen.main.bounds.height - (f.size.height-by)
            self.frame = CGRect(x: f.origin.x, y: y, width: f.size.width, height: f.size.height - by)
        }
    }
    
    public func removeRows(atIndexPaths: [IndexPath], removeItemsFromData:@escaping ((_ indexPaths: [IndexPath])->Void)){
        tableView.beginUpdates()
        removeItemsFromData(atIndexPaths)
        tableView.deleteRows(at: atIndexPaths, with: .right)
        tableView.endUpdates()
        tableView.reloadData()
        decrementTableHeight()
    }
    
    
    public func isDeliveryItemsValid(deliveryItems: [DeliveryItem], completion:@escaping((_ err:ResponseError?,_ items:[DeliveryItem])->Void)){
        
        let err = ResponseError()
        err.errorTitle = "Invalid Input"
        
        var items = [DeliveryItem]()
        
//        if deliveryItems.count == 1 && deliveryItems[0].itemName.isEmpty && deliveryItems[0].quantity < 0{
//            err.reason = "Please enter valid name and quantity."
//            
//        }
        
        for i in 0..<deliveryItems.count{
            
            if deliveryItems[i].itemName.isEmpty && deliveryItems[i].quantity > 1{
                let indexPath = IndexPath(row: i, section: 0)
                tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
                err.reason = "Item name is required."
                completion(err, items)
            }else if  !deliveryItems[i].itemName.isEmpty && deliveryItems[i].quantity < 1{
                let indexPath = IndexPath(row: i, section: 0)
                tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
                err.reason = "Quantity should be One or more."
                completion(err, items)
            }else if !deliveryItems[i].itemName.isEmpty && deliveryItems[i].quantity > 0{
                items.append(deliveryItems[i])
            }
        }
        return completion(nil, items)
    }
 
}
