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
    private var ref: DatabaseReference = {
        Database.database().isPersistenceEnabled = true
        return Database.database().reference()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SWFirebaseProblemManager().getProblems()
        self.view.backgroundColor = .black
    }

}
