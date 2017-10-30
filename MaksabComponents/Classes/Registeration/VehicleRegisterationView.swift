//
//  VehicleRegisterationView.swift
//  Pods
//
//  Created by Incubasys on 11/09/2017.
//
//

import UIKit
import StylingBoilerPlate

public enum DocumentState: Int{
    case NotAddedYet = 0
    case InProgress = 1
    case Failed = 2
    case Uploaded = 3
}

public protocol VehicleRegisterationViewDelegate{
    func actionAddImage()
}
public class VehicleRegisterationView: UIView, NibLoadableView, CustomView {

    @IBOutlet weak var staticVehicleRegisterationLabel: UILabel!
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var state = DocumentState.NotAddedYet
    public var delegate: VehicleRegisterationViewDelegate?
    
    var contentView: UIView!
    let bundle = Bundle(for: VehicleRegisterationView.classForCoder())
    
    override required public init(frame: CGRect) {
        super.init(frame: frame)
        contentView = commonInit(bundle: bundle)
        configView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        contentView = commonInit(bundle: bundle)
        configView()
    }
    
    func configView()  {
        staticVehicleRegisterationLabel.text = "Vehicle Registeration"
        updateState(state: state)
    }
    
    public func updateState(state: DocumentState)  {
        var img: UIImage!
        let bh = BundleHelper(resourceName: Constants.resourceName)
        switch state {
        case .NotAddedYet:
            img = bh.getImageFromMaksabComponent(name: "plus", _class: VehicleRegisterationView.self)
//                UIImage(named: "plus")
            btn.isHidden = false
            activityIndicator.stopAnimating()
        case .InProgress:
            img = bh.getImageFromMaksabComponent(name: "plus", _class: VehicleRegisterationView.self)
            activityIndicator.startAnimating()
            btn.isHidden = true
        case .Failed:
            img = bh.getImageFromMaksabComponent(name: "info", _class: VehicleRegisterationView.self)
            img = img?.imageWithColor(color1: UIColor(netHex: 0xBF2326))
            activityIndicator.stopAnimating()
            btn.isHidden = false
        case .Uploaded:
            img = bh.getImageFromMaksabComponent(name: "checkmark", _class: VehicleRegisterationView.self)
//                UIImage(named: "checkmark")
            activityIndicator.stopAnimating()
            btn.isHidden = false
        }
        btn.setImage(img.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    @IBAction func actionBtn(){
        delegate?.actionAddImage()
    }
}
