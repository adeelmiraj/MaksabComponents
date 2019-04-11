//
//  Double+custom.swift
//  ActionCableClient
//
//  Created by Mansoor Ali on 08/02/2018.
//

import Foundation
public extension Double{
    
    public var localize: String {
        return localizedValue()
    }
    
    private func localizedValue() -> String {
        return String.localizedStringWithFormat("%.2f", self)
    }
}
