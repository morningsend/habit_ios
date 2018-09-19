//
//  Challenge.swift
//  ThirtyDayChallengePrototype
//
//  Created by Zaiyang Li on 12/09/2018.
//  Copyright © 2018 smallteam. All rights reserved.
//

import Foundation
import RealmSwift

class ChallengeDefinition : Object {
    
    @objc dynamic
    var id: String = ""
    
    @objc dynamic
    var title: String = "" {
        didSet {
            
        }
    }
    
    @objc dynamic
    var numberOfDays: Int = -1 {
        didSet {
            
        }
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    private func computePrimaryKey() {
        self.id = "\(title):\(numberOfDays)"
    }
}
