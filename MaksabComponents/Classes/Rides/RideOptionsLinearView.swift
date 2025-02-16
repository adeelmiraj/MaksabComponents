//
//  RideOptionsLinearView.swift
//  Pods
//
//  Created by Incubasys on 04/08/2017.
//
//

import UIKit
import StylingBoilerPlate

public class RideOptionsLinearView: UIView , CustomView, NibLoadableView{
    
    static let height:CGFloat = 39
    static public func createInstance(x: CGFloat, y: CGFloat, width:CGFloat) -> RideOptionsLinearView{
        let inst = RideOptionsLinearView(frame: CGRect(x: x, y: y, width: width, height: RideOptionsLinearView.height))
        return inst
    }
    
    let bundle = Bundle(for: RideOptionsLinearView.classForCoder())
    
    @IBOutlet weak public var btnMehramRide: ToggleButton!
    @IBOutlet weak public var btnPayment: ToggleButton!
    @IBOutlet weak public var btnNoOfPassegners: ToggleButton!
    
    var view: UIView!

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
        btnMehramRide.selectedStateImage = UIImage.image(named: "mehram-selected")
        btnMehramRide.unSelectedStateImage = UIImage.image(named: "mehram")
        
//        btnNoSmoking.selectedStateImage = UIImage.image(named: "smoking")
//        btnNoSmoking.unSelectedStateImage = UIImage.image(named: "no-smoking")

        btnPayment.selectedStateImage = UIImage.image(named: "cash-circle")
        btnPayment.unSelectedStateImage = UIImage.image(named: "cash-circle")
        
        btnNoOfPassegners.selectedStateImage = UIImage.image(named: "passengers")
        btnNoOfPassegners.unSelectedStateImage = UIImage.image(named: "passengers")
        
        btnMehramRide.setTitle("", for: .normal)
//        btnNoSmoking.setTitle("", for: .normal)
        btnPayment.setTitle("", for: .normal)
        btnNoOfPassegners.setTitle("", for: .normal)
   
    }

    
    //MARK:- Setters
	public func config(isMehram: Bool, paymentIcon: UIImage?){
        btnMehramRide.stateSelected = isMehram
		setPayment(icon: paymentIcon)
        btnNoOfPassegners.stateSelected = btnNoOfPassegners.stateSelected
    }
    

    //Payment
	public func setPayment(icon: UIImage?){
        btnPayment.setImage(icon?.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    //MARK:- Getters
	/*
    public func getRideOptions() -> RideOptions {
        guard rideOptions != nil else {
            return RideOptions()
        }
        return rideOptions!
    }*/
}

