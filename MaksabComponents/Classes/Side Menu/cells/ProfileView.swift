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
    
    override required public init(frame: CGRect) {
        super.init(frame: frame)
        let bundle = Bundle(for: type(of: self))
        self.commonInit(bundle: bundle)
        profilePic.layer.cornerRadius = 58/2
        profilePic.backgroundColor = UIColor.appColor(color: .Medium)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let bundle = Bundle(for: type(of: self))
        self.commonInit(bundle: bundle)
        profilePic.layer.cornerRadius = 58/2
        profilePic.backgroundColor = UIColor.appColor(color: .Medium)
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    func config()  {
        
    }
    
    

}
