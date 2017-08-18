//
//  DeliveryTracking.swift
//  Pods
//
//  Created by Incubasys on 11/08/2017.
//
//

import UIKit
import StylingBoilerPlate

public class DeliveryTrackingView: UIView, CustomView, NibLoadableView, SlidableView {
    
    public static let minHeight: CGFloat = 248
    //225
    let bundle = Bundle(for: DeliveryTrackingView.classForCoder())
    
    @IBOutlet weak var staticLabelEta: UILabel!
    @IBOutlet weak var staticLabeltotal: UILabel!
    @IBOutlet weak var staticLabelpriceUnit: UILabel!
    @IBOutlet weak var estimatedTime: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    
    @IBOutlet weak var userPhoto: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userPhoneNo: UILabel!
    
    @IBOutlet weak var staticLabelMyOrder: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    var contentView: UIView!
    
    public var deliveryItems = [DeliveryItem](){
        didSet{
            self.collectionView.reloadData()
        }
    }
    
    static let collectionViewCellHeight:CGFloat = 283   
    //    public var tableView: UITableView!
//    var delegate: DeliveryTrackingViewDelegate?
    
    let bh = BundleHelper(resourceName: Constants.resourceName)
    
    static public func createInstance(x: CGFloat, width: CGFloat, noOfDeliveryItems: Int) -> DeliveryTrackingView{
//        let collectionViewHeight = DeliveryTrackingView.collectionViewCellHeight * CGFloat( noOfDeliveryItems / 2 )
//        let height  = DeliveryTrackingView.minHeight + CGFloat(collectionViewHeight)
        let height = DeliveryTrackingView.getCalculatedHeight(noOfDeliveryItems: noOfDeliveryItems)
        let y = UIScreen.main.bounds.height - height
        let inst = DeliveryTrackingView(frame: CGRect(x: x, y: y, width: width, height: height))
        return inst
    }
    
    public static func getCalculatedHeight(noOfDeliveryItems: Int) -> CGFloat{
        let temp = CGFloat(noOfDeliveryItems) / 2
        var noOfRows = noOfDeliveryItems / 2
        if temp - CGFloat(noOfRows) > 0{
            noOfRows += 1
        }
        let incrementInHeight = DeliveryTrackingView.collectionViewCellHeight * CGFloat(noOfRows)
        let height = DeliveryTrackingView.minHeight + incrementInHeight
        return height
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
        staticLabelEta.text = "eta"
        estimatedTime.text = "01:06:45"
        
        staticLabeltotal.text = "Total"
        staticLabelpriceUnit.text = "SAR"
        totalPrice.text = "45"
        
        userName.text = "Mohammad Ali"
        userPhoneNo.text = "0000092222"
        userPhoto.backgroundColor = UIColor.appColor(color: .Medium)
        userPhoto.layer.cornerRadius = userPhoto.frame.size.height / 2
        
        staticLabelMyOrder.text = "My Order"

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SimpleTextCollectionViewCell.self, bundle: bundle)
//        tableView.register(DeliveryItemTableViewCell.self, bundle: bundle)
        self.hide(animated: false)
    }
}

extension DeliveryTrackingView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return deliveryItems.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeCell(indexPath: indexPath) as SimpleTextCollectionViewCell
        let deliveryItem = deliveryItems[indexPath.row]
        let string = "\(deliveryItem.quantity) x \(deliveryItem.itemName)"
        cell.labelTitle.text = string
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/2, height: DeliveryTrackingView.collectionViewCellHeight)
    }
}
