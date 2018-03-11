//
//  MarkedProblemsView.swift
//  testTind
//
//  Created by Uladzislau Abramchuk on 11.03.2018.
//  Copyright © 2018 Uladzislau Abramchuk. All rights reserved.
//

import UIKit
class SWMarkedProblemsView: UIView {
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor(displayP3Red: 232/255, green: 237/255, blue: 243/255, alpha: 1)
//        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
        tableView.separatorColor = .clear
        tableView.register(SWMarkedProblemCell.self, forCellReuseIdentifier: SWMarkedProblemCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(tableView)
        setTableViewPosition()
    }
    
    private func setTableViewPosition() {
        tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
