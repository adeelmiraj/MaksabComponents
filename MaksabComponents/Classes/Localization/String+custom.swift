//
//  File.swift
//  Pods
//
//  Created by Incubasys on 04/08/2017.
//
//

import Foundation
extension String {
    public static var languageKey: String {
        return "i18n_language"
    }
    
    func localized(bundle: Bundle) -> String {
        if let _ = UserDefaults.standard.string(forKey: .languageKey) {} else {
            // we set a default, just in case
            UserDefaults.standard.set("en", forKey: .languageKey)
            UserDefaults.standard.synchronize()
        }
        
        let lang = UserDefaults.standard.string(forKey: .languageKey)
        
        let path = bundle.path(forResource: lang, ofType: "lproj")
        let bundle = Bundle(path: path!)
        
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
}
