//
//  AnimatableDelegate.swift
//  testTind
//
//  Created by Uladzislau Abramchuk on 03.02.2018.
//  Copyright © 2018 Uladzislau Abramchuk. All rights reserved.
//

import Foundation
protocol ImageAnimateDelegate {
    func prepareImageIncreasing(completionHandler: @escaping () -> Void)
    func prepareImageReducing()
}
