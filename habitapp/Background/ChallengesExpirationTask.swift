//
//  BackgroundTask.swift
//  habitapp
//
//  Created by Zaiyang Li on 18/09/2018.
//  Copyright © 2018 smallteam. All rights reserved.
//

import Foundation
import RealmSwift

func ChallengesExpirationTask(realm: Realm) {
    let results = realm
        .objects(Challenge.self)
        .filter("status == .ongoing")
    
    try! realm.write {
        
    }
}
