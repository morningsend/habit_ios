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
    func markDown(day: Int) -> Void
}

class ChallengeProgressTableCell : UITableViewCell {
    public static let reuseId : String = "ChallengeProgressTableCell"
    
    @IBOutlet var checkbox: M13Checkbox! {
        didSet {
            print("hello checkbox")
            checkbox.addTarget(self,
                               action: #selector(checkboxTouched(sender:)),
                               for: .valueChanged)
        }
    }
    
    @IBOutlet var dayLabel: UILabel!
    
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
            progressDelegate?.markDown(day: 0)
            break
        default:
            break
        }
    }
}
