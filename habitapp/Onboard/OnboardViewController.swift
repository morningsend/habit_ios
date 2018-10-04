//
//  OnboardViewController.swift
//  habitapp
//
//  Created by Zaiyang Li on 04/10/2018.
//  Copyright © 2018 smallteam. All rights reserved.
//

import Foundation
import UIKit


class OnboardViewController : UIViewController {
    
    @IBOutlet var getStartedButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        getStartedButton.addTarget(
            self,
            action: #selector(onPress(sender:)),
            for: .touchUpInside)
    }
    
    @objc
    func onPress(sender: Any?){
        self.dismissSelf(animated: true)
    }
}
