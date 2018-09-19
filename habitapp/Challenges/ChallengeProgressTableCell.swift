//
//  ChallengeProgressTableCell.swift
//  ThirtyDayChallengePrototype
//
//  Created by Zaiyang Li on 16/09/2018.
//  Copyright © 2018 smallteam. All rights reserved.
//

import Foundation
import UIKit
import M13Checkbox

protocol ChallengeProgressActions {
    func markAsDone(challengeId: String, day: Int) -> Void
    func markAsSkipped(challengeId: String, day: Int) -> Void
    func showDetail(challengeId: String) -> Void
}

protocol ChallengeProgressTableCellView {
    var title: String { get set }
    var id: String { get set }
    var progress: Float { get set }
    var daysAgoStarted: Int { get set }
}

class ChallengeProgressTableCell : UITableViewCell, ChallengeProgressTableCellView {
    var title: String = ""
    var progress: Float = 0
    var daysAgoStarted: Int = 0
    var id: String = ""
    public static let reuseId : String = "ChallengeProgressTableCell"
    
    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var checkbox: M13Checkbox! {
        didSet {
            print("hello checkbox")
            checkbox.addTarget(self,
                               action: #selector(checkboxTouched(sender:)),
                               for: .valueChanged)
        }
    }
    
    
    public var progressDelegate: ChallengeProgressActions? = nil
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: ChallengeProgressTableCell.reuseId)
        //setupComponents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //setupComponents()
    }
    
    
    @objc
    func checkboxTouched(sender: M13Checkbox) {
        print(sender.checkState)
        switch(sender.checkState) {
        case .checked:
            break
        default:
            break
        }
    }
}
