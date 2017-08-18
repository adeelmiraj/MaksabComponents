//
//  StartRideView.swift
//  Pods
//
//  Created by Incubasys on 08/08/2017.
//
//

import UIKit
import StylingBoilerPlate

//public protocol StartRideViewDelegate{}

public class StartRideView: UIView, CustomView, NibLoadableView, SlidableView {
    
    public static let height:CGFloat = 310
    
    @IBOutlet weak var userInfoContainerView: UIView!
    
    @IBOutlet weak var labelStartCode: CalloutLabel!
    @IBOutlet weak var labelCode: ShoutnoteLabel!
    @IBOutlet weak var locationName: TitleLabel!
    @IBOutlet weak var city: TextLabel!
    @IBOutlet weak var locationIcon: UIImageView!
    
    var userInfoView: UserInfoWithDetailsBtnView!
    
    var view: UIView!
    let bundle = Bundle(for: StartRideView.classForCoder())
//    public var delegate: StartRideViewDelegate?
    
    static public func createInstance(x: CGFloat, y: CGFloat = UIScreen.main.bounds.height - StartRideView.height, width: CGFloat) -> StartRideView{
        let inst = StartRideView(frame: CGRect(x: x, y: y, width: width, height: StartRideView.height))
//        inst.delegate = delegate
        return inst
    }
    
    override public required init(frame: CGRect) {
        super.init(frame: frame)
        view = commonInit(bundle: bundle)
        configView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        view = commonInit(bundle: bundle)
        configView()
    }
    
    
    func configView()  {
        labelStartCode.text = "Start Code"
        labelCode.text = "Code"
        
        userInfoView = UserInfoWithDetailsBtnView.createInstance(x: 0, y: 0, width: self.frame.size.width)
        userInfoContainerView.addSubview(userInfoView)
        userInfoView.btnDetails.isHidden = true
        userInfoView.bottomSeparator.isHidden = true
        
        locationName.text = "King Khalid International Airport"
        city.text = "Riyadh"
        let bh = BundleHelper(resourceName: Constants.resourceName)
        locationIcon.image = bh.getImageFromMaksabComponent(name: "loc", _class: StartRideView.self)

        hide(animated: false)
    }
    
    
    public func config(){
        userInfoView.config()
    }
    

}
