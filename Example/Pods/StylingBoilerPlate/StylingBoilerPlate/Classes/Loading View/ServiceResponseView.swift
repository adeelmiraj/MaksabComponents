//
//  SevericeResponseView.swift
//  71stStreet
//
//  Created by Pantera Engineering on 14/12/2016.
//  Copyright © 2016 Incubasys IT Solutions. All rights reserved.
//

import UIKit

public protocol ServiceResponseViewDelegate {
    func actionRetry()
}

public class ServiceResponseView: UIView, NibLoadableView, CustomView {


    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelTitle: TitleLabel!
    @IBOutlet weak var labelError: TextLabel!
    @IBOutlet weak var btnRetry: UIButton!
    var v: UIView!
    var delegate :ServiceResponseViewDelegate?
    let bundle = Bundle(for: ServiceResponseView.classForCoder())
    
    override required public init(frame: CGRect) {
        super.init(frame: frame)
        v = commonInit(bundle: bundle)
        configView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        v = commonInit(bundle: bundle)
        configView()
    }
    
    func configView()  {
        btnRetry.tintColor = UIColor.appColor(color: .Secondary)
        btnRetry.setTitleColor(UIColor.appColor(color: .Secondary), for: .normal)
        btnRetry.addTarget(self, action: #selector(actionRetry), for: .touchUpInside)
    }
    
    
    func actionRetry() {
        delegate?.actionRetry()
    }
    
    func showMessage(title:String?, msg: String?, image: UIImage?, hideRetryButton: Bool) {
        labelTitle.text = title
        labelError.text = msg
        imageView.image = image
        if hideRetryButton{
            btnRetry.isHidden = true
        }else{
            btnRetry.isHidden = false
        }
    }//showMessage
}

