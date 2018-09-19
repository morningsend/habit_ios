//
//  RealmChallengeManager.swift
//  ThirtyDayChallengePrototype
//
//  Created by Zaiyang Li on 18/09/2018.
//  Copyright © 2018 smallteam. All rights reserved.
//

import Foundation
import RealmSwift

class RealmChallengeManager : NSObject, ChallengeManager {


    func startOver(challenge: Challenge, date: Date?) {
        let newChallenge = try! Challenge.startOver(challenge: challenge, date: date ?? Date())
        try! realm.write {
            realm.add(newChallenge)
        }
    }
    
    func abandonChallenge(challenge: Challenge) {
        
        try! realm.write {
            challenge.status = .abandoned
        }
    }
    
    func ongoingChallenges() -> Array<Challenge> {
        return []
    }
    
    func completedChallenges() -> Array<Challenge> {
        return []
    }
    
    func abandonedChallenges() -> Array<Challenge> {
        return[]
    }
    
    func getChallenge(id: Int) -> Challenge? {
        return realm
            .objects(Challenge.self)
            .filter("id == \(id)")
            .first
    }
    
    func startNew(definition: ChallengeDefinition, date: Date?) -> Challenge? {
        let startDate = date ?? Date()
        let newChallenge = Challenge
            .startNew(useDefinition: definition, date: startDate)
        try! realm.write {
            realm.add(newChallenge)
        }
        return newChallenge
    }
    
    private weak var realm: Realm!
    required init(realm: Realm) {
        self.realm = realm
    }
}
