//
//  ExtensionString.swift
//  TODO App
//
//  Created by Marcin Kaliniak on 31/05/2019.
//  Copyright © 2019 Marcin Kaliniak. All rights reserved.
//
import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
