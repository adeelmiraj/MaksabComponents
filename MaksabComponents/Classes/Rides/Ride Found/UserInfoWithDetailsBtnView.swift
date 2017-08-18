//
//  UserInfoWithDetailsBtnView.swift
//  Pods
//
//  Created by Incubasys on 07/08/2017.
//
//

import UIKit
import StylingBoilerPlate

class UserInfoWithDetailsBtnView: UIView, CustomView, NibLoadableView {

    static let height: CGFloat = 124
    static let height2: CGFloat = 109
    
    var view: UIView!
    let bundle = Bundle(for: UserInfoWithDetailsBtnView.classForCoder())
    
    @IBOutlet weak var userName: TitleLabel!
    @IBOutlet weak var carName: TextLabel!
    @IBOutlet weak var info: TextLabel!
    @IBOutlet weak var price: TextLabel!
    @IBOutlet weak var btnDetails: SecondaryButton!
    @IBOutlet weak var ratingView: RatingView!
    @IBOutlet weak var userPhoto: UIImageView!
    
    @IBOutlet weak var bottomSeparator: UIView!
    
    static public func createInstance(x: CGFloat, y: CGFloat = UIScreen.main.bounds.height - UserInfoWithDetailsBtnView.height, width: CGFloat) -> UserInfoWithDetailsBtnView{
        let inst = UserInfoWithDetailsBtnView(frame: CGRect(x: x, y: y, width: width, height: height))
        return inst
    }
    
    override required init(frame: CGRect) {
        super.init(frame: frame)
        view = commonInit(bundle: bundle)
        configView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        view = commonInit(bundle: bundle)
        configView()
    }
    
    func configView()  {
        userPhoto.backgroundColor = UIColor.appColor(color: .Medium)
        userPhoto.layer.cornerRadius = userPhoto.frame.size.height/2
        
        btnDetails.setTitle("Details", for: .normal)
    }
    
    func config()  {
        userName.text = "Mohammad Ali"
        carName.text = "Mercedes S63 AMG"
        info.text = "RA-203"
        price.text = "SAR 40"
    }
    
}
