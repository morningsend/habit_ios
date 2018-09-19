//
//  Button.swift
//  ThirtyDayChallengePrototype
//
//  Created by Zaiyang Li on 16/09/2018.
//  Copyright © 2018 smallteam. All rights reserved.
//

import Foundation
import UIKit


class Button : UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var buttonColor: UIColor? {
        didSet {
            layer.borderColor = buttonColor?.cgColor
            layer.backgroundColor = buttonColor?.cgColor
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(frame: CGRect, cornerRadius: CGFloat, buttonColor: UIColor?, title: String?) {
        super.init(frame: frame)
        setupStyle(cornerRadius: cornerRadius, buttonColor: buttonColor, title: title)
    }
    
    
    private func setupStyle(cornerRadius: CGFloat, buttonColor: UIColor?, title: String?) {
        self.cornerRadius = cornerRadius
        self.buttonColor = buttonColor
        titleLabel?.text = title
    }
    
    override var isEnabled : Bool {
        didSet {
            if(isEnabled) {
                self.backgroundColor = self.buttonColor
                self.titleLabel?.textColor = UIColor.white
            } else {
                self.backgroundColor = UIColor.clear
                self.titleLabel?.textColor = buttonColor
            }
        }
    }
}
