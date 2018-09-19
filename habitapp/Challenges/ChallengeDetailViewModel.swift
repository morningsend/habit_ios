//
//  ChallengeDetailViewModel.swift
//  ThirtyDayChallengePrototype
//
//  Created by Zaiyang Li on 16/09/2018.
//  Copyright © 2018 smallteam. All rights reserved.
//

import Foundation

enum ChallengeProgressRecord {
    
}

protocol ChallengeDetailViewModel {
    var dateStarted : NSDate { get }
    var titleString: String { get }
    var length: Int { get }
    
    func progressRecordAt(date: NSDate) -> ChallengeProgressRecord
    func progressRecordAt(index: Int) -> ChallengeProgressRecord
}
