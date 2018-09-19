//
//  Challenge.swift
//  ThirtyDayChallengePrototype
//
//  Created by Zaiyang Li on 12/09/2018.
//  Copyright © 2018 smallteam. All rights reserved.
//

import Foundation
import RealmSwift

@objc
enum WeekDay: Int {
    case monday = 0
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    case sunday
}

@objc
enum Frequency : Int {
    case daily
    case weekly
    case monthly
}

@objc
enum ChallengeStatus: Int{
    typealias RawValue = Int
    
    case notStarted
    case ongoing
    case abandoned
    case restarted
    case completed
}

enum ChallengeErrors : Error{
    case startOverDateMustBeGreater
}

class Challenge : Object {
    
    @objc dynamic
    var id: String = UUID().uuidString
    
    @objc dynamic
    var definition: ChallengeDefinition? = nil
    
    @objc dynamic
    var startDate: Date = Date(timeIntervalSince1970: 0.0)
    
    @objc dynamic
    var endDate: Date = Date(timeIntervalSince1970: 0.0)
    
    @objc dynamic
    var frequency: Frequency = .daily
    
    let daysProgress: List<Int> = List<Int>()
    
    @objc dynamic
    var status: ChallengeStatus = .notStarted
    
    @objc dynamic
    var relatedChallenge: Challenge?
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    /**
        comutes a score between [0, 1.0] to indicate completeness, 1.0 for completed, 0.0 for just started
     */
    func progress() -> Double {
        return 0.0
    }
    
    func markAsCompletedForDate(date: Date) -> Challenge {
        return self
    }
    
    func markAsCompletedForToday() -> Challenge {
        return self
    }
    
    func start() {
        self.status = .ongoing
    }
    
    func computeEndDate() {
        endDate = Calendar.current.date(byAdding: .day, value: definition?.numberOfDays ?? 0, to: startDate)!
    }
    static func startNew(useDefinition: ChallengeDefinition, date: Date) -> Challenge {
        let newChallenge = Challenge()
        newChallenge.startDate = date
        newChallenge.definition = useDefinition
        newChallenge.computeEndDate()
        return newChallenge
    }

    static func startOver(challenge: Challenge, date: Date) throws -> Challenge{
        guard date >= challenge.startDate else {
            throw ChallengeErrors.startOverDateMustBeGreater
        }
        
        let newChallenge = Challenge()
        newChallenge.startDate = date
        newChallenge.definition = challenge.definition
        newChallenge.frequency = challenge.frequency
        newChallenge.computeEndDate()
        return newChallenge
    }
}

extension Date {
    func with(_ component: Calendar.Component, _ value: Int) -> Date? {
        return Calendar.current.date(bySetting: component, value: value, of: self)
    }
    
    func withHourMinuteSecondToZero() -> Date {
        let newDate = self
            .with(.hour, 0)?
            .with(.minute, 0)?
            .with(.second, 0)
        return newDate ?? self
    }
}
