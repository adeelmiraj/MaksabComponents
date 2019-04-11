//
//  MaksabTheme.swift
//  ActionCableClient
//
//  Created by Mansoor Ali on 30/03/2018.
//

import UIKit

public enum MaksabThemeType{
	case lightContent
	case darkContent
}

public struct MaksabTheme {
	
	static public func set(navigationBar: UINavigationBar, theme: MaksabThemeType){
		switch theme {
		case .lightContent:
			setStatusBar(style: .lightContent)
			setNavBar(navigationBar: navigationBar, tintColor: UIColor.appColor(color: .Light))
		case .darkContent:
			setStatusBar(style: .default)
			setNavBar(navigationBar: navigationBar, tintColor: UIColor.appColor(color: .Dark))
		}
	}
	
	private static func setNavBar(navigationBar: UINavigationBar, tintColor: UIColor){
		navigationBar.tintColor = tintColor
		navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: tintColor]
	}
	
	private static func setStatusBar(style: UIStatusBarStyle){
		UIApplication.shared.statusBarStyle = style
	}
}
