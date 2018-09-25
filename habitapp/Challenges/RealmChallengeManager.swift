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
    
    func startOver(challenge: Challenge, date: Date?) -> Challenge? {
        let newChallenge = try! Challenge.startOver(challenge: challenge, date: date ?? Date())
        do {
            try realm.write {
                realm.add(newChallenge)
            }
        } catch {
            return nil
        }
        return newChallenge
    }
    
    func abandonChallenge(challenge: Challenge) {
        
        try! realm.write {
            challenge.status = .abandoned
        }
    }
    
    func ongoingChallenges() -> Results<Challenge> {
        return realm.objects(Challenge.self)
    }
    
    func completedChallenges() -> Results<Challenge> {
        return realm.objects(Challenge.self)
    }
    
    func abandonedChallenges() -> Results<Challenge> {
        return realm.objects(Challenge.self)
    }
    
    func getChallenge(id: Int) -> Challenge? {
        return realm
            .objects(Challenge.self)
            .filter("id == \(id)")
            .first
    }
    
    func startNew(definition: ChallengeDefinition, date: Date?) -> Challenge? {
        let startDate = date ?? Date()
        var newChallenge: Challenge? = nil
        do {
            try realm.write {
                newChallenge = Challenge
                    .startNew(useDefinition: definition, date: startDate)
                realm.add(newChallenge!)
            }
        } catch {
            return nil
        }
        return newChallenge
    }
    
    func startNew(title: String, days: Int, date: Date?) -> Challenge? {
        if let def = definitionRepository.findBy(title: title, andDuration: days) {
            return startNew(definition: def, date: date)
        } else if let def = definitionRepository.create(title: title, andDuration: days) {
            return startNew(definition: def, date: date)
        }
        return nil
    }
    
    private weak var realm: Realm!
    private var definitionRepository: ChallengeDefinitionRepository!
    
    required init(realm: Realm) {
        self.realm = realm
        self.definitionRepository = RealmChallengeDefinitions(realm: realm)
    }
}
