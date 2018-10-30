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
        staticVehicleRegisterationLabel.text = Bundle.localizedStringFor(key: "Vehicle Registeration")
        updateState(state: state)
    }
    
    public func updateState(state: DocumentState)  {
        var img: UIImage!
        switch state {
        case .NotAddedYet:
            img = UIImage.image(named: "plus")
            btn.isHidden = false
            activityIndicator.stopAnimating()
        case .InProgress:
            img = UIImage.image(named: "plus")
            activityIndicator.startAnimating()
            btn.isHidden = true
        case .Failed:
            img = UIImage.image(named: "info")
            img = img?.imageWithColor(color1: UIColor(netHex: 0xBF2326))
            activityIndicator.stopAnimating()
            btn.isHidden = false
        case .Uploaded:
            img = UIImage.image(named: "checkmark")
            activityIndicator.stopAnimating()
            btn.isHidden = false
        }
        btn.setImage(img.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    @IBAction func actionBtn(){
		guard delegate != nil else {
			return
		}
        delegate?.actionAddImage()
    }
}
