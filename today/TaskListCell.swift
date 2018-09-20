//
//  TaskListCell.swift
//  today
//
//  Created by Zaiyang Li on 20/09/2018.
//  Copyright © 2018 smallteam. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

protocol TaskListCellActions {
    func done(id: String)
    func skipped(id: String)
}
protocol TaskListCellView {
    var id: String { get set }
    var title: String { get set }
    var subtitle: String { get set }
    var eventHandler: TaskListCellActions? { get set }
}

class TaskListCell : UITableViewCell, TaskListCellView {
    var id: String = ""

    var title: String = "" {
        didSet {
            self.textLabel?.text = title
        }
    }
    func setTitle(title: String) {
        self.textLabel?.text = title
    }
    var subtitle: String = "" {
        didSet {
            self.detailTextLabel?.text = subtitle
        }
    }
    
    var eventHandler: TaskListCellActions? = nil
    static let reuseId = String(describing: TaskListCell.self)
    
    private var doneButton : UIButton!
    private var skipButton: UIButton!
    
    private func setupUI() {
        doneButton = UIButton()
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.setTitle("Done", for: .normal)
        doneButton.titleLabel?.textAlignment = .center
        doneButton.backgroundColor = UIColor.green
        
        skipButton = UIButton()
        skipButton.translatesAutoresizingMaskIntoConstraints = false
        skipButton.setTitle("Skip", for: .normal)
        skipButton?.titleLabel?.textAlignment = .center
        skipButton.backgroundColor = UIColor.red
        
        doneButton.addTarget(self,
                             action: #selector(doneClicked(sender:)),
                             for: .touchUpInside)
        skipButton.addTarget(self,
                             action: #selector(skipClicked(sender:)),
                             for: .touchUpInside)
        
        contentView.addSubview(doneButton)
        contentView.addSubview(skipButton)
        
    }
    @objc
    func doneClicked(sender: Any) {
        eventHandler?.done(id: id)
    }
    
    @objc
    func skipClicked(sender: Any) {
        eventHandler?.skipped(id: id)
    }
    
    private func layoutUI() {
        let container = self.contentView
        
        skipButton.snp.makeConstraints { (make) in
            make.size.equalTo(container.snp.height)
            make.right.equalTo(container.snp.right)
            make.left.equalTo(doneButton.snp.right)
        }
        doneButton.snp.makeConstraints { (make) in
            make.size.equalTo(container.snp.height)
            make.right.equalTo(skipButton.snp.left)
        }
    }
    override func layoutSubviews() {
        layoutUI()
        super.layoutSubviews()
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: TaskListCell.reuseId)
        selectionStyle = .none
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
