//
//  ChallengeHomeViewModel.swift
//  habitapp
//
//  Created by Zaiyang Li on 25/09/2018.
//  Copyright © 2018 smallteam. All rights reserved.
//

import Foundation
import RealmSwift

protocol ChallengeHomeViewModel {
    func getChallenges()
    func bind(view: ChallengeHomeView)
    func unbind()
}

class ChallengeHomeViewModelImpl : NSObject, ChallengeHomeViewModel {
    private var view: ChallengeHomeView? = nil
    private var challengesManager: ChallengeManager!
    required init(_ challengesManager: ChallengeManager) {
        super.init()
        self.challengesManager = challengesManager
    }
    
    func getChallenges() {
        guard view != nil else {
            return
        }
        print("getting challenges")
        view?.challenges = challengesManager.ongoingChallenges()
    }
    
    func bind(view: ChallengeHomeView) {
        self.view = view
    }
    
    func unbind() {
        self.view = nil
    }
    
}
