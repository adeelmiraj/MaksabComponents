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
    func showHome()
    @objc optional func showPayment()
    @objc optional func showMyTrips()
    func showWallet()
    func showHelp()
    func showSettings()
    func showInviteFriends()
}

public struct SideMenuItem{
    var icon: UIImage
    var title: String
    
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
        cell.backgroundColor = UIColor.appColor(color: .Dark)
        cell.config(icon: sideMenuItem.icon, title: sideMenuItem.title, subtitle: nil, rightButtonTitle: nil, delegate: nil)
        return cell
    }

 

    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard indexPath.section == 2 else {
            return
        }
        
        var row = indexPath.row
        
        if appType == .Driver && row >= 2{
            row += 1
        }
        switch row {
        case 0:
            delegate?.showHome()
        case 1:
            if appType == .Rider{
                delegate?.showPayment!()
            }else{
                delegate?.showProfile()
            }
        case 2:
            delegate?.showMyTrips!()
        case 3:
            delegate?.showWallet()
        case 4:
            delegate?.showHelp()
        case 5:
            delegate?.showSettings()
        case 6:
            delegate?.showInviteFriends()
        default:
            return
        }
        
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
}
