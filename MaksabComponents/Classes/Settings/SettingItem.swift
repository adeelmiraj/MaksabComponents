//
//  SettingItem.swift
//  Pods
//
//  Created by Incubasys on 20/09/2017.
//
//

import Foundation
public struct SettingItem: ToggleableSetting {
    public var title: String
    public var isOn: Bool
    public init(title: String, isOn: Bool) {
        self.title = title
        self.isOn = isOn
    }
}
