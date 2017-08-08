//
//  LuxuryRideView.swift
//  Pods
//
//  Created by Incubasys on 07/08/2017.
//
//

import UIKit
import StylingBoilerPlate

public protocol LuxuryRideViewDelegate {
    func toggleRideOption(rideOption: RideOptions, state: Bool)
}
public class LuxuryRideView: UIView, CustomView, NibLoadableView, SlidableView {
    
    let bundle = Bundle(for: LuxuryRideView.classForCoder())
    
    var contentView: UIView!
    var rideOptionsLinearView: RideOptionsLinearView!
    public var delegate: LuxuryRideViewDelegate?
    
    @IBOutlet weak var buttonsContainerView: UIView!
    
    @IBOutlet weak var btnExoticRide: ToggleBottomTitleButton!
    
    @IBOutlet weak public var tableView: UITableView!
    
    static public let initialHeight: CGFloat = 150
//    static public let height: CGFloat = 326
    
    static public func createInstance(x: CGFloat, y: CGFloat = UIScreen.main.bounds.height - LuxuryRideView.initialHeight, width: CGFloat, delegate: LuxuryRideViewDelegate) -> LuxuryRideView{
        let inst = LuxuryRideView(frame: CGRect(x: x, y: y, width: width, height: LuxuryRideView.initialHeight))
        inst.delegate = delegate
        return inst
    }
    
    override required public init(frame: CGRect) {
        super.init(frame: frame)
        contentView = commonInit(bundle: bundle)
        configView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        contentView = commonInit(bundle: bundle)
        configView()
    }
    
    func configView()  {
        let bh = BundleHelper(resourceName: Constants.resourceName)
        
        btnExoticRide.isUserInteractionEnabled = false
        let img = bh.getImageFromMaksabComponent(name: "luxury-car", _class: LuxuryRideView.self)
        btnExoticRide.setImage(img, for: .normal)
        btnExoticRide.setTitle("Luxury Ride", for: .normal)
        btnExoticRide.stateSelected = true
        
        //tableView
//        tableView.frame = CGRect(x: tableView.frame.origin.x, y: tableView.frame.origin.y, width: tableView.frame.size.width, height: 0)
        tableView.rowHeight = 110
        tableView.register(UserInfoWithTwoBtnsTableViewCell.self, bundle: bundle)
        self.hide(animated: false)
        
        //add RideOptionsLinearView
        rideOptionsLinearView = RideOptionsLinearView.createInstance(x: 0, y: 0, width: self.frame.size.width)
        rideOptionsLinearView.delegate = self
        buttonsContainerView.addSubview(rideOptionsLinearView)
    }
    
    public func incrementTableHeight(by:CGFloat = 110)  {
        let f = self.frame
        let y = UIScreen.main.bounds.height - (f.size.height+110)
        if y >= 44{
            self.frame = CGRect(x: f.origin.x, y: y, width: f.size.width, height: f.size.height + by)
        }
//        let t = self.tableView.frame
//        self.tableView.frame = CGRect(x: t.origin.x, y: t.origin.y, width: t.size.width, height: t.size.height + 110)
    }
    
    public func addRows(atIndexPaths: [IndexPath], addItemsToData:@escaping ((_ indexPaths: [IndexPath])->Void), noOfItemsInData:@escaping(()->Int)){
//        luxuryView.incrementTableHeight()
//        
//        //        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.2) {
//        
//        self.cellCount += 1
//        self.luxuryView.tableView.beginUpdates()
//        //        let cell = UserInfoWithTwoBtnsTableViewCell()
//        let indexPath = IndexPath(item: self.cellCount-1, section: 0)
//        self.luxuryView.tableView.insertRows(at: [indexPath], with: .top)
//        self.luxuryView.tableView.endUpdates()
//        let height = luxuryView.tableView.contentSize.height - luxuryView.tableView.frame.size.height
//        if cellCount-1 > 0 && height > 0{
//            let i = IndexPath(row: cellCount-1, section: 0)
//            luxuryView.tableView.scrollToRow(at: i, at: .bottom, animated: true)
//        }
        incrementTableHeight()
        addItemsToData(atIndexPaths)
        tableView.beginUpdates()
        tableView.insertRows(at: atIndexPaths, with: .top)
        tableView.endUpdates()
        let height = tableView.contentSize.height - tableView.frame.size.height
        let dataItemsCount = noOfItemsInData()
        if dataItemsCount > 0 && height > 0{
            let i = IndexPath(row: dataItemsCount-1, section: 0)
            tableView.scrollToRow(at: i, at: .bottom, animated: true)
        }
//        tableView.reloadData()
    }
    public func removeRows(atIndexPaths: [IndexPath], removeItemsFromData:@escaping ((_ indexPaths: [IndexPath])->Void)){
//        luxuryView.tableView.beginUpdates()
//        cellCount -= 1
//        luxuryView.tableView.deleteRows(at: [indexPath], with: .right)
//        luxuryView.tableView.endUpdates()
//        luxuryView.tableView.reloadData()
//        self.luxuryView.decrementTableHeight()
        tableView.beginUpdates()
        removeItemsFromData(atIndexPaths)
        tableView.deleteRows(at: atIndexPaths, with: .right)
        tableView.endUpdates()
        tableView.reloadData()
        decrementTableHeight()
    }
    public func decrementTableHeight(by:CGFloat = 110)  {
        let f = self.frame
        let height = tableView.contentSize.height - (tableView.frame.size.height-110)
        print(height)
        if f.size.height > 150 && height <= -1{
            let y = UIScreen.main.bounds.height - (f.size.height-110)
            self.frame = CGRect(x: f.origin.x, y: y, width: f.size.width, height: f.size.height - by)
        }
        
//        let t = self.tableView.frame
//        self.tableView.frame = CGRect(x: t.origin.x, y: t.origin.y, width: t.size.width, height: t.size.height - 110)
    }
}

extension LuxuryRideView: RideOptionsDelegate{
    
    public func rideOptioinToggled(rideOption: RideOptions, state: Bool){
        delegate?.toggleRideOption(rideOption: rideOption, state: state)
    }
    
    public func isMehramRide() -> Bool{
        return rideOptionsLinearView.btnMehramRide.stateSelected
    }
    
    public func isNoSmoking() -> Bool{
        return rideOptionsLinearView.btnNoSmoking.stateSelected
    }
}
