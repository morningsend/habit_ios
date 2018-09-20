//
//  ChallengeTableViewCell.swift
//  ThirtyDayChallengePrototype
//
//  Created by Zaiyang Li on 13/09/2018.
//  Copyright © 2018 smallteam. All rights reserved.
//

import Foundation
import UIKit

protocol ChallengeTableCellView {
    var title: String { get set }
    var daysCompleted: Int { get set }
    var progress: Float { get set }
    var challengeId: String { get set }
}


protocol ChallengeTableCellEvents {
    func onSelect(challengeId: String)
}

class ChallengeTableViewCell : UITableViewCell, ChallengeTableCellView {
    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    
    var daysCompleted: Int = 0 {
        didSet {
            dateStartedLabel.text = "\(daysCompleted) day(s) completed"
        }
    }
    
    var progress: Float = 0.0 {
        didSet {
            progressBar.progress = progress
        }
    }
    
    var challengeId: String = ""
    
    static let reuseId = "ChallengeTableViewCell"
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateStartedLabel: UILabel!
    @IBOutlet var progressBar: UIProgressView!
    
    func configure(id: String?,
                   title: String?,
                   dateStarted: Date,
                   progress: Double) {
        self.challengeId = id ?? ""
        self.title = title ?? ""
        self.daysCompleted = 0
        self.progress = Float(progress)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: ChallengeTableViewCell.reuseId)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
