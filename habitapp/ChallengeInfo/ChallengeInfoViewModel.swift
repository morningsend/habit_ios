//
//  ChallengeInfoViewModel.swift
//  habitapp
//
//  Created by Zaiyang Li on 25/09/2018.
//  Copyright © 2018 smallteam. All rights reserved.
//

import Foundation

protocol ChallengeInfoViewModel {
    func getChallenge(challengeId: String)
    func markDone(challengeId: String)
    func bind(view: ChallengeInfoView)
    func unbind()
}
