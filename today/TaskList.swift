//
//  TaskListsViewController.swift
//  today
//
//  Created by Zaiyang Li on 20/09/2018.
//  Copyright © 2018 smallteam. All rights reserved.
//

import Foundation
import UIKit

class TaskList: NSObject, UITableViewDelegate, UITableViewDataSource, TaskListCellActions {
    
    private var tableView : UITableView?
    private var rows = 8
    func bind(tableView: UITableView) {
        self.tableView = tableView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskListCell.reuseId, for: indexPath)
        if let taskCell = cell as? TaskListCell {
            taskCell.title = "Drink 2L of water"
            taskCell.subtitle = "5 day(s) to go"
            taskCell.eventHandler = self
            taskCell.id = "id-xxxxx"
        }
        return cell
    }
    
    override init() {
        super.init()
    }
    
    func done(_ cellView: TaskListCellView, id: String) {
        print("done \(id)")
    }
    
    func skipped(_ cellView: TaskListCellView, id: String) {
        if let cell = cellView.asTableViewCell() {
            if let indexPath = tableView?.indexPath(for: cell) {
                tableView(tableView!, commit: .delete, forRowAt: indexPath)
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            // delete item at indexPath
        }
        
        let share = UITableViewRowAction(style: .default, title: "Share") { (action, indexPath) in
            // share item at indexPath
            
        }
        share.backgroundColor = UIColor.lightGray
        
        return [delete, share]
        
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return " 3 / 5 habits completed"
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            let aniamtedFrame = cell.frame.offsetBy(dx: -40, dy: 0)
            UIView.animate(withDuration: 0.3) {
                // cell.frame = aniamtedFrame
            }
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch(editingStyle) {
        case .delete:
            rows -= 1
            tableView.deleteRows(at: [indexPath], with: .automatic)
            break
        default:
            break
        }
    }
    
}
