//
//  MarkedViewController.swift
//  testTind
//
//  Created by Uladzislau Abramchuk on 23.02.2018.
//  Copyright © 2018 Uladzislau Abramchuk. All rights reserved.
//

import UIKit
import Firebase

class SWMarkedProblemsController: UIViewController {
    let markedView: SWMarkedProblemsView
    let presenter: SWMarkedPresenter
    var tableView: UITableView { return markedView.tableView }
    
    
    init(presenter: SWMarkedPresenter) {
        self.presenter = presenter
        self.markedView = SWMarkedProblemsView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view = markedView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Text"
        self.tableView.dataSource = presenter
        self.tableView.delegate = presenter
//        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 15, bottom: 40, right: -15)
        presenter.getProblems()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

}
