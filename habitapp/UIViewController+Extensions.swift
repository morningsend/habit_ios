//
//  UIViewController+Extensions.swift
//  habitapp
//
//  Created by Zaiyang Li on 04/10/2018.
//  Copyright © 2018 smallteam. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func dismissSelf(animated: Bool = true) {
        if let nav = self.navigationController {
            nav.popViewController(animated: animated)
        } else {
            self.dismiss(animated: animated, completion: nil)
        }
    }
}
