//
//  SideMenuTemplateTableViewController.swift
//  Pods
//
//  Created by Incubasys on 25/07/2017.
//
//

import UIKit
import StylingBoilerPlate

public enum AppType {
    case Rider
    case Driver
}

@objc public protocol SideMenuDelegate {
    func showProfile()
//    func showHome()
//    @objc optional func showPayment()
//    @objc optional func showMyTrips()
//    func showWallet()
//    func showHelp()
//    func showSettings()
//    func showInviteFriends()
    func menuItemSelected(atIndexPath: IndexPath)
}

public struct SideMenuItem{
    public var icon: UIImage
    public var title: String
    
    public init(icon: UIImage, title: String) {
        self.icon = icon
        self.title = title
    }
}

public protocol SideMenuDataSource{
    func viewForHeader() -> UIView?
    func sideMenuItems() -> [SideMenuItem]
    func appType() -> AppType
}


open class SideMenuTableViewController: UIViewController,UITableViewDataSource, UITableViewDelegate, NibLoadableView {
    
    @IBOutlet weak public var tableView: UITableView!
    
    public var dataSource: SideMenuDataSource?
    public var delegate: SideMenuDelegate?
    let bundle = Bundle(for: SideMenuTableViewController.classForCoder())
    
    public var sideMenuItems = [SideMenuItem]()
    var headerView: UIView?
    var appType: AppType = .Rider
    
    override open func loadView() {
        guard let view = bundle.loadNibNamed(SideMenuTableViewController.nibName, owner: self, options: nil)?.first as? UIView else {
            fatalError("Nib not found.")
        }
        self.view = view
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        guard dataSource != nil else {
            fatalError("SideMenuTemplateTableViewController dataSource is not implemented")
        }
        headerView = dataSource!.viewForHeader()
        let tapeGesture = UITapGestureRecognizer(target: self, action: #selector(actionHeaderView))
        headerView?.addGestureRecognizer(tapeGesture)
        
        sideMenuItems = dataSource!.sideMenuItems()
        appType = dataSource!.appType()
        
        tableView.backgroundColor = UIColor.appColor(color: .Dark)
        self.automaticallyAdjustsScrollViewInsets = false
        
        tableView.register(LeftIconTableViewCell.self, bundle: bundle)
        tableView.rowHeight = 52
        
        let footerView = UIView()
        footerView.backgroundColor = UIColor.appColor(color: .Dark)
        tableView.tableFooterView = footerView
    }

    func actionHeaderView()  {
        delegate?.showProfile()
    }
    
    // MARK: - Table view data source

     open func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        guard headerView != nil else {
            return 1
        }
        return 2
    }

    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return 0
        default:
            return sideMenuItems.count
        }
    }
    
    open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard headerView != nil else {
            return 0
        }
        return headerView!.frame.size.height
    }
    
    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView!
    }

    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeCell(indexPath: indexPath) as LeftIconTableViewCell
        let sideMenuItem = sideMenuItems[indexPath.row]
//        cell.backgroundColor = UIColor.appColor(color: .Dark)
        cell.isLight = false
        cell.config(icon: sideMenuItem.icon, title: sideMenuItem.title, subtitle: nil)
        return cell
    }

 

    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard indexPath.section == 1 else {
            return
        }
        delegate?.menuItemSelected(atIndexPath: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
