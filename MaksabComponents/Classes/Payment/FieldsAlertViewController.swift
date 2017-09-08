//
//  FieldsAlertViewController.swift
//  Pods
//
//  Created by Incubasys on 15/08/2017.
//
//

import UIKit
import StylingBoilerPlate

public protocol FieldsAlertViewControllerDelegate{
    func noOfField() -> Int
    func configField(field: DarkBorderTextField, position: Int)
    func configPrimaryButton(primaryButton: PrimaryButton)
    func configDestructiveButton(destructiveButton: DestructiveButton)
}

open class FieldsAlertViewController: UIViewController {

    public static let fieldHeight: CGFloat = 33
    public static let minHeight: CGFloat = 100
    //141
    public var delegate: FieldsAlertViewControllerDelegate?
    var cardView: CardView!
    
    var noOfFields: Int = 1
    public var fieldsArray: [DarkBorderTextField]!
    public var destructiveButton: DestructiveButton!
    public var primaryButton: PrimaryButton!
    
   
    override open func viewDidLoad() {
        super.viewDidLoad()

        guard delegate != nil else {
            fatalError("delegete is not implemented")
        }
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        noOfFields = delegate!.noOfField()
        let fieldsHeight = CGFloat(noOfFields) * FieldsAlertViewController.fieldHeight
        let topAndBottomSpace = CGFloat(noOfFields-1) * 12
        
        let cardHeight = FieldsAlertViewController.minHeight + fieldsHeight + topAndBottomSpace
        let y = (self.view.frame.size.height/2) - (cardHeight/2)
        cardView = CardView(frame: CGRect(x: 8, y: y, width: self.view.frame.size.width-16, height: cardHeight))
        cardView.backgroundColor = UIColor.appColor(color: .Light)
        cardView.layoutSubviews()
        self.view.addSubview(cardView)
        
        addFields()
        
        addButtonView(cardheight: cardHeight)
        self.view.layoutSubviews()
    }

    func addFields()  {
        fieldsArray = []
        for i in 0..<noOfFields{
            var y = CGFloat(i)*(FieldsAlertViewController.fieldHeight+12)
            y += 16
            
            
            let field = DarkBorderTextField()
            field.frame = CGRect(x: 16, y: y, width: cardView.frame.size.width-32, height: FieldsAlertViewController.fieldHeight)
            field.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
            cardView.addSubview(field)
            fieldsArray.append(field)
            delegate!.configField(field: field, position: i)
        }
    }
    
    func addButtonView(cardheight: CGFloat)  {
        let y = cardheight-48-16
        let view = UIView(frame: CGRect(x: 16, y: y, width: cardView.frame.size.width-32, height: 48))
        destructiveButton = DestructiveButton(type: .system)
        destructiveButton.frame = CGRect(x: 0, y: 0, width: (view.frame.size.width/2)-12, height: view.frame.size.height)
        view.addSubview(destructiveButton)
        delegate!.configDestructiveButton(destructiveButton: destructiveButton)
        
        primaryButton = PrimaryButton(type: .system)
        primaryButton.frame = CGRect(x: (view.frame.size.width/2)+12, y: 0, width: (view.frame.size.width/2)-12, height: view.frame.size.height)
        view.addSubview(primaryButton)
        delegate!.configPrimaryButton(primaryButton: primaryButton)
        
        self.cardView.addSubview(view)
    }
}
