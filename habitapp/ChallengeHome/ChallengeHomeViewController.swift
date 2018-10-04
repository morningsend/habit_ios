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
    private var viewModel: ChallengeHomeViewModel!
    
    @IBOutlet var newButton: UINavigationItem!
    
    
    private var refresh: UIRefreshControl!
    private var notificationToken: NotificationToken?
    
    private var segments: UISegmentedControl!
    
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
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.clear
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 16
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
        //return UIStatusBarStyle.default   // Make dark again
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, done) in
            print("Delete challenge")
            done(true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
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
        //self.tableView.refreshControl = refresh
        
        refresh.addTarget(self,
                          action: #selector(reloadChallenges(sender:)),
                          for: .valueChanged)
        
        emptyView = EmptyChallengeView(frame: view.frame, label: "No challenges yet. Tap the plus button above to set one.")
        
        
        newButton.rightBarButtonItem?.setTarget(
            target: self,
            action: #selector(showNewChallengeView(sender:))
        )
        
        segments = UISegmentedControl(items: ["Active", "Done"])
        segments.tintColor = UIColor.white
        segments.selectedSegmentIndex = 0
        segments.addTarget(self, action: #selector(segmentValueChanged(sender:)), for: .valueChanged)
        segments.translatesAutoresizingMaskIntoConstraints = false
    self.navigationController?.navigationBar.addSubview(segments)
        
        let container = self.navigationController!.navigationBar
        
        segments.snp.makeConstraints { (make) in
            make.centerX.equalTo(container.snp.centerX)
            make.top
                .equalTo(container.snp.top)
                .offset(12)
        }
    }
    
    @objc
    func segmentValueChanged(sender: UISegmentedControl) {
        print(sender.selectedSegmentIndex)
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
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        guard challenges != nil else {
            return 0
        }
        
        return challenges!.count
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    
    func setupTableView() {
        tableView.showsVerticalScrollIndicator = false
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ChallengeTableViewCell.reuseId, for: indexPath)
        guard challenges != nil else {
            return cell
        }
        
        if let challengeCell = cell as? ChallengeTableViewCell {
            let challenge = challenges![indexPath.section]
            challengeCell.title = challenge.definition?.title ?? "<challenge>"
        }
        return cell
        
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

