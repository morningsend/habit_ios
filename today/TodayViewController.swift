//
//  TodayViewController.swift
//  today
//
//  Created by Zaiyang Li on 20/09/2018.
//  Copyright © 2018 smallteam. All rights reserved.
//

import UIKit
import NotificationCenter
import SnapKit

class TodayViewController: UIViewController, NCWidgetProviding {
    
    private var tableView: UITableView!
    private var allCompletedLabel: UILabel!
    private var taskList: TaskList!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        setupUI()
        self.extensionContext?.widgetLargestAvailableDisplayMode = .expanded
    }
    func setupUI() {
        taskList = TaskList()
        tableView = UITableView()
        allCompletedLabel = UILabel()
        
        allCompletedLabel.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = taskList
        tableView.dataSource = taskList
        tableView.isHidden = true
        tableView.register(TaskListCell.self, forCellReuseIdentifier: TaskListCell.reuseId)
        allCompletedLabel.text = "All tasks completed!"
        allCompletedLabel.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        allCompletedLabel.textColor = UIColor.white
        allCompletedLabel.textAlignment = .center
        
        view.addSubview(allCompletedLabel)
        view.addSubview(tableView)
    }
    
    func layoutUI() {
        guard self.view != nil else {
            return
        }
        
        let container = self.view!
        
        allCompletedLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(container)
            make.centerY.equalTo(container)
            make.left.equalTo(container).offset(20)
            make.right.equalTo(container).offset(-20)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(container)
            make.bottom.equalTo(container)
            make.left.equalTo(container)
            make.right.equalTo(container)
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutUI()
        
        
    }
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        allCompletedLabel.isHidden = true
        tableView.isHidden = false
        
        completionHandler(NCUpdateResult.newData)
    }
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        let tableHeight = 44 * CGFloat(tableView.numberOfRows(inSection: 0))
        switch(activeDisplayMode) {
        case .expanded:
            self.preferredContentSize = CGSize(width: maxSize.width, height: min(tableHeight, maxSize.height))
            break
        case .compact:
            self.preferredContentSize = CGSize(width: view.frame.width, height: 44 * 3)
            break
        }
    }
}
