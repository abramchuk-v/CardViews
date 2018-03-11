//
//  SWMarkedAssemly.swift
//  testTind
//
//  Created by Uladzislau Abramchuk on 11.03.2018.
//  Copyright © 2018 Uladzislau Abramchuk. All rights reserved.
//

import UIKit


// Wrap everything into protocols.

class SWMarkedAssemly {
    let vc: SWMarkedProblemsController
    init(problemManager: SWProblemManager) {
        let presentr = SWMarkedPresenter(problemManager: problemManager)
        self.vc = SWMarkedProblemsController(presenter: presentr)
        presentr.vc = self.vc
    }
}
