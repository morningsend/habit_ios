//
//  NewChallengeView.swift
//  habitapp
//
//  Created by Zaiyang Li on 20/09/2018.
//  Copyright © 2018 smallteam. All rights reserved.
//

import Foundation

protocol NewChallengeActions {
    func onCreate(title: String, days: Int, startDate: Date) -> Void
}

protocol NewChallengeView {
    var title: String? { get }
    var durationDays: Int? { get }
    var buttonEnabled: Bool { get set }
}
