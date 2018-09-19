//
//  ChallengeInfoViewController.swift
//  ThirtyDayChallengePrototype
//
//  Created by Zaiyang Li on 13/09/2018.
//  Copyright © 2018 smallteam. All rights reserved.
//

import Foundation
import UIKit

class ChallengeInfoViewController : UIViewController {
    var preferLargeTitle: Bool = false;
    
    @IBOutlet var action: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        action.setTarget(target: self,
                         action: #selector(self.showActions(sender:)))
        action.customView = UIButton(type: .infoLight)
    }
    
    @objc
    func showActions(sender: UIBarButtonItem) -> Void {
        let alertController = ChallengeInfoViewController
            .challengeAlertActionController(
                startOverHandler: self.startOver,
                abandonHandler: self.abandon
            )
        present(alertController, animated: true, completion: nil)
    }
    func startOver(action: UIAlertAction) -> Void {
        print("starting over")
        self.navigationController?.popViewController(animated: true)
    }
    
    func abandon(action: UIAlertAction) -> Void {
        print("abandoning")
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.preferLargeTitle = self.navigationController?.navigationBar.prefersLargeTitles ?? false
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = self.preferLargeTitle
        super.viewDidDisappear(animated)
    }
    
    static func challengeAlertActionController(
        startOverHandler: ((UIAlertAction) -> Void)?,
        abandonHandler: ((UIAlertAction) -> Void)? ) -> UIAlertController {
        let alertController = UIAlertController(
            title: nil,
            message: nil,
            preferredStyle: .actionSheet)
        
        let cancelAlertAction = UIAlertAction(
                title: "Cancel",
                style: .cancel) { (alertAction) in
            
        }
        
        let abandonAlertAction = UIAlertAction(
                title:"Abandon challenge",
                style: .destructive,
                handler: abandonHandler)
        
        let startOverAction = UIAlertAction(
            title: "Start over challenge",
            style: .default,
            handler: startOverHandler)
        
        alertController.addAction(startOverAction)
        alertController.addAction(abandonAlertAction)
        alertController.addAction(cancelAlertAction)
        
        return alertController
    }
}

extension UIBarButtonItem {
    func setTarget(target: AnyObject?, action: Selector?) -> Void {
        self.action = action
        self.target = target
    }
}
