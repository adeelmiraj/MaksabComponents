//
//  String+custom.swift
//  Pods
//
//  Created by Incubasys on 14/09/2017.
//
//

import Foundation

extension String{
    public static  func boldAttributedString(boldComponent: String, otherComponent: String, boldFont: UIFont, otherfont: UIFont, textColor: UIColor, boldTextColor: UIColor = UIColor.appColor(color: .DarkText),  boldFirst: Bool = true) -> NSAttributedString {
        
        let boldAttrs = [NSFontAttributeName: boldFont, NSForegroundColorAttributeName: boldTextColor]
        let boldAttributedString = NSAttributedString(string:"\(boldComponent) ", attributes: boldAttrs)
        
        let otherAttrs = [NSFontAttributeName: otherfont, NSForegroundColorAttributeName: textColor]
        let otherAttributedString = NSAttributedString(string:"\(otherComponent)", attributes: otherAttrs)
        
        let finalAttributedString: NSMutableAttributedString!
        if boldFirst{
            finalAttributedString = NSMutableAttributedString(attributedString: boldAttributedString)
            finalAttributedString.append(otherAttributedString)
        }else{
            finalAttributedString = NSMutableAttributedString(attributedString: otherAttributedString)
            finalAttributedString.append(boldAttributedString)
        }
        
        return finalAttributedString
    }
    
    public static func getMaxHeight(text: String, font: UIFont, width: CGFloat, maxHeight: CGFloat) -> CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width,height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        
        let height = label.frame.size.height + 16
        
        if height > maxHeight{
            return maxHeight
        }else{
            return height
        }
    }

	func localized() -> String {
		return NSLocalizedString(self, tableName: "Localizable", bundle: Bundle.stylingBoilerPlateBundle, value: "ABC", comment: "Localized string")
	}
}
