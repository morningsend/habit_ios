//
//  ViewController.swift
//  ThirtyDayChallengePrototype
//
//  Created by Zaiyang Li on 09/09/2018.
//  Copyright © 2018 smallteam. All rights reserved.
//

import UIKit
import SnapKit

class ChallengeHomeViewController: UITableViewController {
    var emptyView: UIView!
    
    let challenges: Array<String> = ["Drink 2L of water","Drink 2L of water"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.setupTableView()
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 80
        tableView.backgroundColor = UIColor.black
        
        emptyView = EmptyChallengeView(frame: view.frame, label: "No challenges yet. Tap the plus button above to set one.")
        setupTitle()
    }
    var addButton: UIButton!
    
    private func setupTitle() {
        guard self.navigationController != nil else {
            return
        }
        
        addButton = UIButton(type: .system)
        addButton.tintColor = UIColor.white
        addButton.backgroundColor = UIColor.darkGray
        addButton.setTitle("+", for: .normal)
        addButton.layer.cornerRadius = 16.0
        let container = (self.navigationController?.navigationBar)!
        
        container.items?.forEach({ (item) in
            item.rightBarButtonItem?.tintColor = UIColor.clear
        })
        
        container.addSubview(addButton)
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.snp.makeConstraints { (make) in
            make.width.equalTo(32)
            make.height.equalTo(32)
            make.right.equalTo(container).offset(-16)
            make.bottom.equalTo(container).offset(-16)
        }
        addButton.alpha = 0.0
        addButton.isEnabled = false
        addButton.addTarget(self,
                            action: #selector(showNewChallengeView(sender:)),
                            for: .touchUpInside)
    }
    
    func setupTableView() {
        tableView.showsVerticalScrollIndicator = false
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return challenges.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChallengeTableViewCell.reuseId, for: indexPath) as! ChallengeTableViewCell
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Today"
    }
    
    @objc func showNewChallengeView(sender: Any) {
        if let vc = NewChallengeViewController.instantiateFromMainStoryboard() {
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        if(challenges.count < 1) {
            self.view = emptyView
        } else {
            self.view = self.tableView
            self.tableView.reloadData()
        }
        addButton.alpha = 1.0
        addButton.isEnabled = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        addButton.alpha = 0.0
        addButton.isEnabled = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

