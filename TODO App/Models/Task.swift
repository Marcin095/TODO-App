//
//  Task.swift
//  TODO App
//
//  Created by Marcin Kaliniak on 30/05/2019.
//  Copyright © 2019 Marcin Kaliniak. All rights reserved.
//

import Foundation
import RealmSwift


class Task: Object {
    
    @objc dynamic var name: String?
    @objc dynamic var category: String?
    @objc dynamic var date: String?

}
