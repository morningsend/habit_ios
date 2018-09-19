//
//  ChallengeManager.swift
//  ThirtyDayChallengePrototype
//
//  Created by Zaiyang Li on 18/09/2018.
//  Copyright © 2018 smallteam. All rights reserved.
//

import Foundation

protocol ChallengeManager {
    
    func abandonChallenge(challenge: Challenge) -> Void
    func ongoingChallenges() -> Array<Challenge>
    func completedChallenges() -> Array<Challenge>
    func abandonedChallenges() -> Array<Challenge>
    func getChallenge(id: Int) -> Challenge?
    func startNew(definition: ChallengeDefinition, date: Date?) -> Challenge?
    func startOver(challenge: Challenge, date: Date?) -> Void
}
