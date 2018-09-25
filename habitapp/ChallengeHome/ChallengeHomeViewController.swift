//
//  ViewController.swift
//  ThirtyDayChallengePrototype
//
//  Created by Zaiyang Li on 09/09/2018.
//  Copyright © 2018 smallteam. All rights reserved.
//

import UIKit
import SnapKit
import RealmSwift

protocol ChallengeHomeView {
    var challenges: Results<Challenge>? { get set }
}

class ChallengeHomeViewController: UITableViewController, ChallengeHomeView {
    var emptyView: UIView!
    var addButton: UIButton!
    private var viewModel: ChallengeHomeViewModel!
    private var refresh: UIRefreshControl!
    private var notificationToken: NotificationToken?
    
    deinit{
        //In latest Realm versions you just need to use this one-liner
        notificationToken?.invalidate()
    }
    
    var challenges: Results<Challenge>? = nil {
        didSet {
            if challenges == nil || challenges!.count < 1 {
                emptyView.isHidden = false
                tableView?.isHidden = true
            } else {
                emptyView.isHidden = true
                tableView?.isHidden = false
            }
            tableView?.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupViewModel()
        notificationToken = Store.shared.realm.observe { note, realm in
            self.viewModel.getChallenges()
        }
    }
    
    private func setupViewModel() {
        viewModel = ChallengeHomeViewModelImpl(RealmChallengeManager(realm: Store.shared.realm))
        viewModel.bind(view: self)
    }
    
    @objc
    func reloadChallenges(sender: AnyObject?) {
        self.refresh.beginRefreshing()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            self.viewModel.getChallenges()
            self.refresh.endRefreshing()
        }
    }
    private func setupUI() {
        guard self.navigationController != nil else {
            return
        }
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.setupTableView()
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 80
        tableView.backgroundColor = UIColor.black
        refresh = UIRefreshControl()
        self.tableView.refreshControl = refresh
        
        refresh.addTarget(self,
                          action: #selector(reloadChallenges(sender:)),
                          for: .valueChanged)
        
        emptyView = EmptyChallengeView(frame: view.frame, label: "No challenges yet. Tap the plus button above to set one.")
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        viewModel.getChallenges()
        if challenges == nil || challenges!.count < 1 {
            self.view = emptyView
        } else {
            self.view = self.tableView
        }
        addButton.alpha = 1.0
        addButton.isEnabled = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        addButton.alpha = 0.0
        addButton.isEnabled = false
    }
    
    
    func setupTableView() {
        tableView.showsVerticalScrollIndicator = false
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard challenges != nil else {
            return 0
        }
        
        return challenges!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ChallengeTableViewCell.reuseId, for: indexPath)
        guard challenges != nil else {
            return cell
        }
        
        if let challengeCell = cell as? ChallengeTableViewCell {
            let challenge = challenges![indexPath.row]
            challengeCell.title = challenge.definition?.title ?? "<challenge>"
        }
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Ongoing"
    }
    
    @objc func showNewChallengeView(sender: Any) {
        if let vc = NewChallengeViewController.instantiateFromMainStoryboard() {
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

