//
//  NewChallengeViewModel.swift
//  habitapp
//
//  Created by Zaiyang Li on 20/09/2018.
//  Copyright © 2018 smallteam. All rights reserved.
//

import Foundation

protocol NewChallengeViewModel {
    func bind(view: NewChallengeView) -> Void
    func createNew(title: String, days: Int) -> Challenge?
}

class NewChallengeViewModelImpl : NSObject, NewChallengeViewModel {
    private var newChallengeView: NewChallengeView? = nil
    private var challengesManager: ChallengeManager? = nil
    
    init(challengesManager: ChallengeManager) {
        self.challengesManager = challengesManager
    }
    
    func bind(view: NewChallengeView) {
        self.newChallengeView = view
    }
    
    func createNew(title: String, days: Int) -> Challenge? {
        return challengesManager?.startNew(title: title, days: days, date: Date())
    }
}
