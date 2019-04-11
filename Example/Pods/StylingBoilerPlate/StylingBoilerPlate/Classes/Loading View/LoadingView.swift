//
//  LoadingBackgroundView.swift
//  Pods
//
//  Created by Incubasys on 26/07/2017.
//
//

import UIKit
//import MRProgress
import SVProgressHUD

public protocol RefreshControlDelegate{
    func refreshData()
}

public class LoadingView: UIView {
    
    private var serviceResponseView : ServiceResponseView?
    public var loadingMessage:String = "Loading..."
    private var loadingIsVisible = false
    private var refreshControl : UIRefreshControl?
    private var pageLoadingView : PageLoadingView!
    
    private var refreshDelegate: RefreshControlDelegate?
    override public func awakeFromNib() {}
    
    public static func show(msg: String = "Loading...",window: UIWindow? = nil){
        if window != nil{
            SVProgressHUD.setContainerView(window!)
        }
        SVProgressHUD.show(withStatus: msg)
    }
    
    public static func hide(){
        SVProgressHUD.dismiss()
    }
    
    //Service Response View
    public func addServiceReponseView(delegate:ServiceResponseViewDelegate,top:CGFloat=0,bottom:CGFloat=0, isLight: Bool = true)  {
        createServiceResponseView(delegate:delegate,top:top,bottom:bottom, isLight: isLight)
    }
    
    func createServiceResponseView(delegate:ServiceResponseViewDelegate,top:CGFloat=0,bottom:CGFloat=0, isLight: Bool) {
        let w = UIScreen.main.bounds.width
        let h = UIScreen.main.bounds.height - top - bottom
        serviceResponseView = ServiceResponseView(frame: CGRect(x: 0, y: top, width: w, height: h))
        serviceResponseView?.delegate = delegate
        serviceResponseView?.isLight = isLight
        self.addSubview(serviceResponseView!)
        self.bringSubview(toFront: serviceResponseView!)
        serviceResponseView?.isHidden = true
    }
    
    
    //Refresh control
    func createRefreshControl(controller: UIViewController, title: String) -> UIRefreshControl {
        let rControl = UIRefreshControl()
        rControl.attributedTitle = NSAttributedString(string: title)
        rControl.addTarget(controller, action: Selector(("refreshData")), for: .valueChanged)
        return rControl
    }
    
    public func addRefreshControl(tableView:UITableView,refreshTitle:String,controller: UIViewController, delegate: RefreshControlDelegate)  {
        self.refreshDelegate = delegate
        refreshControl = createRefreshControl(controller: controller, title: refreshTitle)
        tableView.addSubview(refreshControl!)
    }
    
    public func addRefreshControl(collectionView:UICollectionView,refreshTitle:String,controller: UIViewController, delegate: RefreshControlDelegate)  {
        self.refreshDelegate = delegate
        refreshControl = createRefreshControl(controller: controller, title: refreshTitle)
        collectionView.addSubview(refreshControl!)
    }
    
    //Page Loading view for pagination
    public func addPageLoadingView(bottom:CGFloat = 0)  {
        let w = UIScreen.main.bounds.width
        let y = UIScreen.main.bounds.height - 44 - bottom
        pageLoadingView = PageLoadingView(frame:CGRect(x: 0, y: y, width: w, height: 44))
        pageLoadingView.backgroundColor = UIColor.yellow
        self.addSubview(pageLoadingView)
        
        pageLoadingView.isHidden = true
    }
    
    public func showPageLoading(msg:String = "Loading more...")  {
        pageLoadingView.labelMsg.text = msg
        pageLoadingView.isHidden = false
        loadingIsVisible = true
    }
    
    func hidePageLoading()  {
        pageLoadingView.isHidden = true
    }
    
    public func isLoadingVisible() -> Bool {
        return loadingIsVisible
    }
    
    public func hideLoadingOrMessageView()  {
//        if mrProgressOverlay != nil{
//            mrProgressOverlay.hide(true)
//            mrProgressOverlay = nil
//            self.loadingIsVisible = false
//        }else {
//            serviceResponseView?.isHidden = true
//        }
        if loadingIsVisible{
            LoadingView.hide()
            if pageLoadingView != nil{
               hidePageLoading()
            }
            refreshControl?.endRefreshing()
            loadingIsVisible = false
        }else{
            serviceResponseView?.isHidden = true
        }
    }
    
    //Show Loading View
//    , mode:MRProgressOverlayViewMode = MRProgressOverlayViewMode.indeterminate
    public func showLoadingView(msg: String = "Loading...", window: UIWindow? = nil)  {
        var title = ""
        if msg.isEmpty{
            title = loadingMessage
        }else{
            title = msg
        }
        self.loadingIsVisible = true
        LoadingView.show(msg: title, window: window)
    }
    
    public func showReponseView(title: String?, msg: String?, img: UIImage?, hideRetryBtn: Bool, retryBtnTitle:String = "Try Again")  {
        if serviceResponseView != nil{
            serviceResponseView?.showMessage(title: title, msg: msg, image: img, hideRetryButton: hideRetryBtn, btnTitle: retryBtnTitle)
            serviceResponseView?.btnRetry.setTitle(retryBtnTitle, for: .normal)
            serviceResponseView?.isHidden = false
        }
    }

}


