//
//  ViewController.swift
//  MaksabComponents
//
//  Created by zainincubasys on 07/19/2017.
//  Copyright (c) 2017 zainincubasys. All rights reserved.
//

import UIKit
import MaksabComponents
import StylingBoilerPlate

class ViewController: RegisterationTemplateViewController, RegisterationTemplateViewControllerDataSource, RegisterationTemplateViewControllerDelegate {

    var registerationViewType = RegisterationViewType.PhoneNumber
    var selectRideView: SelectRideView!
    var budgetRideView: BudgetRideView!
    var luxuryView: LuxuryRideView!
    var rideFound: RideFoundView!
    var startRideView: StartRideView!
    var rateRide: RateRideView!
    var cellCount = 0
    
    override open func loadView() {
//        let name = "RegisterationTemplateViewController"
//        let bundle = Bundle(for: type(of: self))
        let bundle = Bundle(for: RegisterationTemplateViewController.classForCoder())
        guard let view = bundle.loadNibNamed(RegisterationTemplateViewController.nibName, owner: self, options: nil)?.first as? UIView else {
            fatalError("Nib not found.")
        }
        self.view = view
        dataSource = self
        delegate = self
        
       
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
       configViews(type: registerationViewType)
    
        if registerationViewType == .VerificationCode{
            configPrimaryButton(image: #imageLiteral(resourceName: "resend"))
        }else if registerationViewType == .InviteCode || registerationViewType == .NameAndEmail{
            configPrimaryButton(image: #imageLiteral(resourceName: "skip"))
        }else if registerationViewType == .Password || registerationViewType == .ForgotPassword{
            configPrimaryButton(image: #imageLiteral(resourceName: "help"))
        }
        
//        selectRideView()
//        showBudgetView()
        
        addBarItems()
//        showLuxuryView()
//        showFoundRide()
//        showStartRide()
        showRateRide()
 
    }
    
    func addBarItems()  {
        let incItem = UIBarButtonItem(title: "plus", style: .plain, target: self, action: #selector(addItem))
//        let decItem = UIBarButtonItem(title: "minus", style: .plain, target: self, action: #selector(decreaseHeight))
        self.navigationItem.rightBarButtonItems = [incItem]
    }
    
    func addItem()  {
        let row = (cellCount == 0) ? 0 : cellCount 
        let indexPath = IndexPath(item: row, section: 0)
        luxuryView.addRows(atIndexPaths: [indexPath], addItemsToData: { (indexPaths) in
            self.cellCount += 1
        }) { () -> Int in
            return self.cellCount
        }
    }
    

    func showLuxuryView()  {
        luxuryView =  LuxuryRideView.createInstance(x: 8, width: UIScreen.main.bounds.width-16, delegate: self)
        self.view.addSubview(luxuryView)
        luxuryView.tableView.dataSource = self
        luxuryView.tableView.delegate = self
        luxuryView.tableView.rowHeight = 110
        luxuryView.show(animated: true)
    }
    
    func showFoundRide()  {
        rideFound = RideFoundView.createInstance(x: 8, width: UIScreen.main.bounds.width-16, delegate: self)
        self.view.addSubview(rideFound)
        rideFound.config()
        rideFound.show(animated: true)
    }
    
    func showStartRide() {
        startRideView = StartRideView.createInstance(x: 8, width: UIScreen.main.bounds.width-16)
        self.view.addSubview(startRideView)
        startRideView.show(animated: true)
        startRideView.config()
    }
    
    func showRateRide()  {
        rateRide = RateRideView.createInstance(x: 8, width: UIScreen.main.bounds.width-16, delegate: self)
        self.view.addSubview(rateRide)
        rateRide.show(animated: true)
        rateRide.config()
    }
    
    func viewType() -> RegisterationViewType{
        return registerationViewType
    }

    func assests() -> RegisterationAssets {
        return RegisterationAssets(logo:#imageLiteral(resourceName: "logo"), tooltip:#imageLiteral(resourceName: "help") , btnNext: #imageLiteral(resourceName: "arrow-thin-right"), facebook:#imageLiteral(resourceName: "facebook"),twitter: #imageLiteral(resourceName: "twitter"), google: #imageLiteral(resourceName: "google"))
    }
    
    //required
    func actionNext(sender: UIButton) {
        let customSideMenu = self.storyboard?.instantiateViewController(withIdentifier: CustomSideMenuViewController.sceneName)
        UIApplication.shared.windows.first?.rootViewController = customSideMenu!
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
//    func showHome()  {
//        let homeController = self.storyboard?.instantiateViewController(withIdentifier: HomeViewController.sceneName)
//        let rootNavController = RootNavigationViewController(rootViewController: homeController!)
////        sideMenuTableViewController.dataSource = rootNavController
////        sideMenuTableViewController.delegate = rootNavController
//        UIApplication.shared.windows.first?.rootViewController = rootNavController
//  
//    }

}

extension ViewController: LuxuryRideViewDelegate, RideFoundViewDelegate, RateRideViewDelegate{
    func rateUser(rating: Double, isRideAgain: Bool) {
        <#code#>
    }

    
//    func toggleRideType(selectedType: RideType){
//    }
    func actDetails(){}
        func actContact(){}
        func actChat(){}
    func toggleRideOption(rideOption: RideOptions, state: Bool){
//        print(rideOption)
//        print(budgetRideView.isMehramRide())
//        print(budgetRideView.isNoSmoking())
    }
    
//    func searchRides() {
//    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate, UserInfoWithTwoBtnsDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeCell(indexPath: indexPath) as UserInfoWithTwoBtnsTableViewCell
        cell.config(indexPath: indexPath, delegate: self)
        cell.userName.text = "\(indexPath.row)"
        return cell
    }
    
    func actPrimary(sender: PrimaryButton, indexPath: IndexPath){}
    func actSecondary(sender: DestructiveButton, indexPath: IndexPath){
//        let cell = luxuryView.tableView.cellForRow(at: indexPath) as? UserInfoWithTwoBtnsTableViewCell
//        print("indexPath:\(indexPath.row)")
//        print("title:\(cell?.userName.text)")

        luxuryView.removeRows(atIndexPaths: [indexPath]) { (indexPaths) in
            self.cellCount -= 1
        }
//        }
        
    }

}

