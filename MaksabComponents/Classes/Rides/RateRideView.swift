//
//  RateRideView.swift
//  Pods
//
//  Created by Incubasys on 08/08/2017.
//
//

import UIKit
import StylingBoilerPlate

public protocol RateRideViewDelegate{
    func rateUser(rating: Double, isRideAgain: Bool)
}
public class RateRideView: UIView, CustomView, NibLoadableView, SlidableView {

    public static let height:CGFloat = 337
    
    
    @IBOutlet weak var titleRateRide: TitleLabel!
    @IBOutlet weak var userPhoto: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var locationName: UILabel!
    @IBOutlet weak var ratingView: RatingView!
    @IBOutlet weak var labelRideAgain: TextLabel!
    @IBOutlet weak var switchRideAgain: UISwitch!
    @IBOutlet weak var btnRateRide: PrimaryButton!
    
    public var delegate: RateRideViewDelegate!
    
    var view: UIView!
    
    let bundle = Bundle(for: RateRideView.classForCoder())
    //    public var delegate: StartRideViewDelegate?
    
    static public func createInstance(x: CGFloat, y: CGFloat = UIScreen.main.bounds.height - RateRideView.height, width: CGFloat, delegate: RateRideViewDelegate) -> RateRideView{
        let inst = RateRideView(frame: CGRect(x: x, y: y, width: width, height: RateRideView.height))
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
        
        titleRateRide.text = "Rate your Ride"
        
        btnRateRide.setTitle("Rate", for: .normal)
        btnRateRide.addTarget(self, action: #selector(actRate), for: .touchUpInside)
        
        userPhoto.backgroundColor =  UIColor.appColor(color: .Medium)
        userPhoto.layer.cornerRadius = userPhoto.frame.size.height / 2
        userName.text = "Trip with Mohammed"
        locationName.text = "King Abdulla Rd"
        
        ratingView.rating = 4
        
        labelRideAgain.text = "Ride again with Mohammed?"
        
        hide(animated: false)
    }
    
    
    @IBAction func actSwitchValueChanged(_ sender: UISwitch) {
        
    }
    
    func actRate()  {
        delegate.rateUser(rating: ratingView.rating, isRideAgain: switchRideAgain.isOn)
    }
    
    public func config(){}
}
