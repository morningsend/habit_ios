//
//  CongratsViewController.swift
//  habitapp
//
//  Created by Zaiyang Li on 04/10/2018.
//  Copyright © 2018 smallteam. All rights reserved.
//

import Foundation
import UIKit

class CongratsViewController : UIViewController {
    
    @IBOutlet var closeButton: UIButton!
    
    override func viewDidLoad() {
        closeButton
            .addTarget(self,
                       action: #selector(onPressClose(sender:)),
                       for: .touchUpInside)
    }
    
    @objc
    func onPressClose(sender: Any) {
        self.dismissSelf(animated: true)
    }
}
