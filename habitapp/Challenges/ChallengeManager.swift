//
//  ChallengeManager.swift
//  ThirtyDayChallengePrototype
//
//  Created by Zaiyang Li on 18/09/2018.
//  Copyright © 2018 smallteam. All rights reserved.
//

import Foundation
import RealmSwift

protocol ChallengeManager {
    
    func abandonChallenge(challenge: Challenge) -> Void
    func ongoingChallenges() -> Results<Challenge>
    func completedChallenges() -> Results<Challenge>
    func abandonedChallenges() -> Results<Challenge>
    func getChallenge(id: Int) -> Challenge?
    func startNew(definition: ChallengeDefinition, date: Date?) -> Challenge?
    func startNew(title: String, days: Int, date: Date?) -> Challenge?
    func startOver(challenge: Challenge, date: Date?) -> Challenge?
}
