//
//  RegisterationTemplateViewController.swift
//  Pods
//
//  Created by Incubasys on 19/07/2017.
//
//

import UIKit

public enum RegisterationViewType {
    case PhoneNumber
    case VerificationCode
    case EmailAndPassword
    case Password
    case PasswordAndConfirmPassword
}

public protocol RegisterationTemplateViewControllerDataSource{
    func viewType() -> RegisterationViewType
}

open class RegisterationTemplateViewController: UIViewController {

//    override open func loadView() {
//        let name = "RegisterationTemplateViewController"
//        let bundle = Bundle(for: type(of: self))
//        guard let view = bundle.loadNibNamed(name, owner: self, options: nil)?.first as? UIView else {
//            fatalError("Nib not found.")
//        }
//        self.view = view
//    }
    
    public var dataSource: RegisterationTemplateViewControllerDataSource?
    
    @IBOutlet weak var firstFieldHeight: NSLayoutConstraint!
    @IBOutlet weak var stackViewHeight: NSLayoutConstraint!
    @IBOutlet weak var stackViewReqHeight: NSLayoutConstraint!
    @IBOutlet weak var socialLoginsView: UIView!
    @IBOutlet weak var fieldsView: UIView!
    
    @IBOutlet weak var logoView: UIView!
    
    override open func viewDidLoad() {
        super.viewDidLoad()

        guard let type = dataSource?.viewType() else {
            fatalError("Missing registeration view controller datasource method viewType")
        }
        config(type: type)
    }
    
    func config(type: RegisterationViewType)  {
        if type != .EmailAndPassword{
            removeFirstField()
        }
        if type != .PhoneNumber{
            removeSocialLoginsView()
        }
    }
    
    func removeFirstField()  {
        firstFieldHeight.constant = 0
        stackViewHeight.constant = 76-26
        stackViewReqHeight.constant = 64-26
    }
    
    func removeSocialLoginsView()  {
        self.socialLoginsView.removeFromSuperview()
        let bottom = NSLayoutConstraint(item: self.view, attribute: .bottom, relatedBy: .greaterThanOrEqual, toItem: self.fieldsView, attribute: .bottom, multiplier: 1, constant: 0)
        self.view.addConstraint(bottom)
    }
    
    open static  func createController(_for:RegisterationViewType) -> RegisterationTemplateViewController{
        
        var vc: RegisterationTemplateViewController!
        
        let bundle = Bundle(for: self.classForCoder())
        let name = "RegisterationTemplateViewController"
        vc = RegisterationTemplateViewController(nibName: name, bundle: bundle)
        
        return vc
    }

}
