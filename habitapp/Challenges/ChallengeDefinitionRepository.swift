//
//  ChallengeDefinitionRepository.swift
//  habitapp
//
//  Created by Zaiyang Li on 24/09/2018.
//  Copyright © 2018 smallteam. All rights reserved.
//

import Foundation
import RealmSwift

protocol ChallengeDefinitionRepository {
    func findBy(title: String) -> LazyFilterCollection<Results<ChallengeDefinition>>
    func findBy(title: String, andDuration days: Int) -> ChallengeDefinition?
    func create(title: String, andDuration days: Int) -> ChallengeDefinition?
}

class RealmChallengeDefinitions: NSObject, ChallengeDefinitionRepository {
    func create(title: String, andDuration days: Int) -> ChallengeDefinition? {
        var def: ChallengeDefinition?
        do {
            try realm.write {
                def = ChallengeDefinition()
                def?.title = title
                def?.numberOfDays = days
                def?.computePrimaryKey()
                realm.add(def!, update: true)
            }
        } catch {
            def = nil
        }
        return def
    }
    
    private weak var realm: Realm!
    
    required init(realm: Realm) {
        super.init()
        self.realm = realm
    }
    
    func findBy(title: String, andDuration days: Int) -> ChallengeDefinition? {
        return realm
            .objects(ChallengeDefinition.self)
            .filter({ (def: ChallengeDefinition) -> Bool in
                return def.title == title && def.numberOfDays == days
            })
            .first
    }
    
    func findBy(title: String) -> LazyFilterCollection<Results<ChallengeDefinition>> {
        return realm
            .objects(ChallengeDefinition.self)
            .filter { (def: ChallengeDefinition) -> Bool in
                return def.title == title
        }
    }
}
