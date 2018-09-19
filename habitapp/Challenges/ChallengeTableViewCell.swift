//
//  ChallengeTableViewCell.swift
//  ThirtyDayChallengePrototype
//
//  Created by Zaiyang Li on 13/09/2018.
//  Copyright © 2018 smallteam. All rights reserved.
//

import Foundation
import UIKit

class ChallengeTableViewCell : UITableViewCell {
    static let reuseId = "ChallengeTableViewCell"
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateStartedLabel: UILabel!

    @IBOutlet var progressBar: UIProgressView!
    
    func configure(title: String?, dateStarted: Date, progress: Double) {
        titleLabel.text = title
        progressBar.setProgress(Float(progress), animated: false)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: ChallengeTableViewCell.reuseId)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
