//
//  UITextField.swift
//  habitapp
//
//  Created by Zaiyang Li on 19/09/2018.
//  Copyright © 2018 smallteam. All rights reserved.
//

import Foundation
import UIKit


extension UITextField {
    func padLeft(points: Float) {
        let height = self.frame.height
        let spacer = UIView(frame: CGRect(x: 0, y: 0, width: CGFloat(points), height: height))
        self.leftView = spacer
    }
}
