//
//  ToggleButtonView.swift
//  StylingBoilerPlate
//
//  Created by Mansoor Ali on 09/11/2017.
//

import UIKit

public protocol ToggleViewDelegate{
    func viewToggled(state: Bool, view: ToggleView)
}

public class ToggleView: UIView, CustomView, NibLoadableView {

    var contentView: UIView!
    public var toggeable: ToggleViewDelegate?
    
    @IBOutlet weak public var icon: UIImageView!
    @IBOutlet weak public var title: UILabel!
    
    public var state: Bool = false{
        didSet{
			guard autoToggle else {
				self.toggeable?.viewToggled(state: self.state, view: self)
				return
			}
            if self.state{
                icon.image = selectedStateImg
                self.title.text = selectedStateTitle
            }else{
                icon.image = unSelectedStateImg
                self.title.text = unSelectedStateTitle
            }
            self.toggeable?.viewToggled(state: self.state, view: self)
        }
    }
    
    public var selectedStateImg: UIImage?
    public var unSelectedStateImg: UIImage?
    public var selectedStateTitle: String?
    public var unSelectedStateTitle: String?
    public var autoToggle = true

    override public required init(frame: CGRect) {
        super.init(frame: frame)
        contentView = commonInit(bundle: Bundle(for: ToggleView.classForCoder()))
        configView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        contentView = commonInit(bundle: Bundle(for: ToggleView.classForCoder()))
        configView()
    }
    
    func configView()  {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(actTapped))
        self.addGestureRecognizer(tapGesture)
        self.title?.font = UIFont.appFont(font: .RubikRegular, pontSize: 14)
        self.title?.lineBreakMode = .byWordWrapping
    }
    
    func actTapped()  {
        state = !state
        self.contentView.alpha = 0.7
        UIView.animate(withDuration: 0.3) {
            self.contentView.alpha = 1
        }
    }
}

