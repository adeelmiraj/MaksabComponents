//
//  Bundle+StylingBoilerPlate.swift
//  StylingBoilerPlate
//
//  Created by Mansoor Ali on 11/04/2019.
//

import Foundation

extension Bundle{

	static var stylingBoilerPlateBundle: Bundle {
		return Bundle(for: DashedBorderButton.classForCoder())
	}
}
