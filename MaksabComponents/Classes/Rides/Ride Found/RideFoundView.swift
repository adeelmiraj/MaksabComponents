//
//  RideFoundView.swift
//  Pods
//
//  Created by Incubasys on 07/08/2017.
//
//

import UIKit
import StylingBoilerPlate

public protocol RideFoundViewDelegate{
    func actDetails()
    func actContact()
    func actChat()
    func toggleRideOption(rideOption: RideOptions, state: Bool)
}

public class RideFoundView: UIView, CustomView, NibLoadableView, SlidableView {

    public static let height:CGFloat = 375
   
    @IBOutlet weak var userInfoContainerView: UIView!
    @IBOutlet weak var rideOptionsContainerView: UIView!
    @IBOutlet weak var btnContact: PrimaryButton!
    @IBOutlet weak var btnChat: SecondaryButton!
    
    var userInfoView: UserInfoWithDetailsBtnView!
    var rideOptionsGridView: RidesOptionsGridView!
    
    var view: UIView!
    let bundle = Bundle(for: UserInfoWithDetailsBtnView.classForCoder())
    public var delegate: RideFoundViewDelegate?
    
    static public func createInstance(x: CGFloat, y: CGFloat = UIScreen.main.bounds.height - RideFoundView.height, width: CGFloat, delegate: RideFoundViewDelegate) -> RideFoundView{
        let inst = RideFoundView(frame: CGRect(x: x, y: y, width: width, height: RideFoundView.height))
        inst.delegate = delegate
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
        
        btnChat.setTitle("Chat", for: .normal)
        btnContact.setTitle("Contact", for: .normal)
        
        userInfoView = UserInfoWithDetailsBtnView.createInstance(x: 0, y: 0, width: self.frame.size.width)
        userInfoContainerView.addSubview(userInfoView)
        userInfoView.btnDetails.addTarget(self, action: #selector(actDetails), for: .touchUpInside)
        
        rideOptionsGridView = RidesOptionsGridView.createInstance(x: 0, y: 0, width: self.frame.size.width)
        rideOptionsGridView.delegate = self
        rideOptionsContainerView.addSubview(rideOptionsGridView)
        rideOptionsGridView.isUserInteractionEnabled = false
        
        
        hide(animated: false)
    }


    public func config(){
        userInfoView.config()
        rideOptionsGridView.config()
    }
    
    func actDetails() {
        delegate?.actDetails()
    }
    @IBAction func actContact(_ sender: PrimaryButton) {
        delegate?.actContact()
    }
    @IBAction func actChat(_ sender: SecondaryButton) {
        delegate?.actChat()
    }
}

extension RideFoundView: RideOptionsDelegate{
    
    func rideOptioinToggled(rideOption: RideOptions, state: Bool) {
        delegate?.toggleRideOption(rideOption: rideOption, state: state)
    }
    
    public func isMehramRide() -> Bool{
        return rideOptionsGridView.isMehramRide()
    }
    
    public func isNoSmoking() -> Bool{
        return rideOptionsGridView.isNoSmoking()
    }

}
