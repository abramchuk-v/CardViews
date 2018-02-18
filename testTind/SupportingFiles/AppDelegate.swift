//
//  AppDelegate.swift
//  testTind
//
//  Created by Uladzislau Abramchuk on 1/18/18.
//  Copyright © 2018 Uladzislau Abramchuk. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        UIApplication.shared.statusBarStyle = .default
        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = SWCardController()
        window!.rootViewController = vc
        window!.makeKeyAndVisible()
        return true
    }
}

