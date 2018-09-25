//
//  Store.swift
//  habitapp
//
//  Created by Zaiyang Li on 25/09/2018.
//  Copyright © 2018 smallteam. All rights reserved.
//

import Foundation
import RealmSwift

class Store {
    static let shared = Store()
    
    let realm: Realm
    
    private init() {
        realm = try! Realm()
    }
}
