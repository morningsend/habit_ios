//
//  EmptyChallengeTable.swift
//  ThirtyDayChallengePrototype
//
//  Created by Zaiyang Li on 16/09/2018.
//  Copyright © 2018 smallteam. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class EmptyChallengeView : UIView {
    private var labelText: String? = nil
    private var label: UILabel? = nil
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(label: String?) {
        super.init(frame: CGRect.zero)
        
        self.labelText = label
        
        setupLayout()
        setupStyle()
    }
    
    init(frame: CGRect, label: String?) {
        super.init(frame: frame)
        
        self.labelText = label
        
        setupLayout()
        setupStyle()
    }
    
    func setupLayout() {
        // container
        let container = self
        
        // label
        label = UILabel()
        label?.translatesAutoresizingMaskIntoConstraints = false
        label?.text = self.labelText
        label?.font = UIFont.systemFont(ofSize: 18.0)
        label?.numberOfLines = 2
        label?.adjustsFontSizeToFitWidth = true
        label?.textAlignment = NSTextAlignment.center
        container.addSubview(label!)
        
        label?.snp.makeConstraints { (make) -> Void in
            make.center.equalTo(container)
            make.left.equalTo(container).offset(40)
            make.right.equalTo(container).offset(-40)
            make.height.greaterThanOrEqualTo(80)
        }
    }
    
    func setupStyle() {
        label?.textColor = UIColor.lightGray
        self.backgroundColor = UIColor.clear
    }
}
