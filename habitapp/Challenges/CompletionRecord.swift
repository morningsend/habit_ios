//
//  CompletionRecord.swift
//  ThirtyDayChallengePrototype
//
//  Created by Zaiyang Li on 12/09/2018.
//  Copyright © 2018 smallteam. All rights reserved.
//

import Foundation

enum TaskStatus {
    case todo
    case completed
    case skipped
}

struct CompletionRecord {
    let createdAt: Date
    let status: TaskStatus
}
