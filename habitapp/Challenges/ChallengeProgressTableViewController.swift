//
//  ChallengeProgressTableViewController.swift
//  ThirtyDayChallengePrototype
//
//  Created by Zaiyang Li on 16/09/2018.
//  Copyright © 2018 smallteam. All rights reserved.
//

import Foundation
import UIKit

class ChallengeProgressTableViewController : UITableViewController {
    private var tapticGenerator: UISelectionFeedbackGenerator? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        //self.tableView.rowHeight = UITableViewAutomaticDimension
        //self.tableView.estimatedRowHeight = 80
        tapticGenerator = UISelectionFeedbackGenerator()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tapticGenerator?.prepare()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: ChallengeProgressTableCell.reuseId,
            for: indexPath
        ) as! ChallengeProgressTableCell
        cell.progressDelegate = self
        return cell
    }
}

extension ChallengeProgressTableViewController : ChallengeProgressActions {
    func markDown(day: Int) {
        tapticGenerator?.selectionChanged()
    }
}
