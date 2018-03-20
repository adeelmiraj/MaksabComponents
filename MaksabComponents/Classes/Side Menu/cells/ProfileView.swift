//
//  ProfileView.swift
//  Pods
//
//  Created by Incubasys on 25/07/2017.
//
//

import UIKit
import StylingBoilerPlate
import Cosmos

public class ProfileView: UIView, NibLoadableView, CustomView{

    
    @IBOutlet weak public var profilePic: UIImageView!
    @IBOutlet weak public var labelName: UILabel!
    @IBOutlet weak public var ratingView: CosmosView!
    @IBOutlet weak public var statusView: UIView!
    @IBOutlet weak public var labelStatus: UILabel!
    @IBOutlet weak public var statusIndicator: UIView!
    
    @IBOutlet weak var statusViewHeight: NSLayoutConstraint!
    @IBOutlet weak public var btnChangeStatus: UIButton!
    var view: UIView!
    public typealias OnTap = () -> Void
    public var changeStatus: OnTap?
    @IBOutlet weak var containerView: UIView!
    
    override required public init(frame: CGRect) {
        super.init(frame: frame)
        let bundle = Bundle(for: type(of: self))
        view = self.commonInit(bundle: bundle)
        configView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let bundle = Bundle(for: type(of: self))
        view = self.commonInit(bundle: bundle)
        configView()
    }
    
    
    func configView()  {
        profilePic.layer.cornerRadius = 58/2
        profilePic.backgroundColor = UIColor.appColor(color: .Medium)
        
        btnChangeStatus.layer.cornerRadius = btnChangeStatus.frame.size.height / 2
        btnChangeStatus.layer.borderWidth = 1
        btnChangeStatus.layer.borderColor = UIColor.appColor(color: .Medium).cgColor
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(actChangeStatus))
        statusView.addGestureRecognizer(tapGesture)
        view.backgroundColor = UIColor.appColor(color: .Primary)
        labelName.textColor = UIColor.appColor(color: .LightText)
        containerView.backgroundColor = UIColor.appColor(color: .Primary)
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    public func showStatusView(){
        statusViewHeight.constant = 21
        statusView.isHidden = false
    }
    
    public func hideStatusView(){
        statusViewHeight.constant = 0
        statusView.isHidden = true
    }
    
    func actChangeStatus() {
        changeStatus?()
    }
    
}
