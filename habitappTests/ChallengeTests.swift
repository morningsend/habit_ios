//
//  ChallengeSpec.swift
//  ThirtyDayChallengePrototypeTests
//
//  Created by Zaiyang Li on 18/09/2018.
//  Copyright © 2018 smallteam. All rights reserved.
//

import Foundation
import Nimble
import Quick
import RealmSwift

@testable import habitapp

class ChallengeSepcs : QuickSpec {
    override func spec() {
        describe("Challenge start new") {
            it("sets correct definition and start date") {
                let definition = ChallengeDefinition(value: [
                    "title": "Drink 2L of water daily",
                    "numberOfDays": 12
                    ])
                
                let date = Date(timeIntervalSinceNow: 0.0)
                
                let challenge = Challenge.startNew(
                    useDefinition: definition,
                    date: date
                )
                
                expect(challenge.startDate).to(equal(date))
                expect(challenge.definition).to(be(definition))
                expect(challenge.status).to(equal(ChallengeStatus.notStarted))
            }
        }
        
        describe("Challenge start over") {
            it("creates new challenge and copies old challennge and sets correct start date") {
                let definition = ChallengeDefinition()
                definition.title = "Drink 2L of water daily"
                definition.numberOfDays = 3
                
                let date = Date(timeIntervalSinceNow: -1000.0)
                let startOverDate = Date(timeIntervalSinceNow: 1000)
                
                let oldChallenge = Challenge.startNew(
                    useDefinition: definition,
                    date: date
                )
                
                let newChallenge = Challenge.startOver(
                    challenge: oldChallenge,
                    date: startOverDate
                )
                expect(oldChallenge.definition!).to(equal(newChallenge.definition!))
                expect(oldChallenge.id).toNot(equal(newChallenge.id))
                expect(oldChallenge.frequency).to(equal(newChallenge.frequency))
                expect(newChallenge.startDate).to(equal(startOverDate))
            }
            
            it("Abandons old challenge") {
                let definition = ChallengeDefinition()
                definition.title = "Drink 2L of water daily"
                definition.numberOfDays = 3
                
                let date = Date(timeIntervalSinceNow: -1000.0)
                
                let oldChallenge = Challenge.startNew(
                    useDefinition: definition,
                    date: date
                )
                
                let startOverDate = Date(timeIntervalSinceNow: 2000)
                let startedOver = Challenge.startOver(challenge: oldChallenge, date: startOverDate)
                
                let newChallenge = Challenge.startOver(
                    challenge: oldChallenge,
                    date: startOverDate
                )
                
                expect(oldChallenge.status).to(equal(ChallengeStatus.abandoned))
                expect(newChallenge.status).to(equal(ChallengeStatus.notStarted))
            }
        }
    }
    
    public func testDummy() {}
}
