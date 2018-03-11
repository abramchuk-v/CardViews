//
//  SWMarkedPresenter.swift
//  testTind
//
//  Created by Uladzislau Abramchuk on 11.03.2018.
//  Copyright © 2018 Uladzislau Abramchuk. All rights reserved.
//

import UIKit

class SWMarkedPresenter: NSObject {
    var vc: SWMarkedProblemsController?
    let problemManager: SWProblemManager
    var problems = [SWProblemObject]()
    
    init(problemManager: SWProblemManager) {
        self.problemManager = problemManager
    }
    
    func getProblems() {
        problemManager.getMarkedProblems { (problems) in
            self.problems = problems
            self.vc?.tableView.reloadData()
        }
    }
}

extension SWMarkedPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return problems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SWMarkedProblemCell.identifier)
        guard let problemCell = cell as? SWMarkedProblemCell else {
            return UITableViewCell()
        }
        problemCell.problem = problems[indexPath.row]
        
        return problemCell
    }
}
extension SWMarkedPresenter: UITableViewDelegate {

}
