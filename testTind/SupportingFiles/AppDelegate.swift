//
//  AppDelegate.swift
//  testTind
//
//  Created by Uladzislau Abramchuk on 1/18/18.
//  Copyright © 2018 Uladzislau Abramchuk. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        let tabBarController = UITabBarController()
        
        let freshProblems = SWFreshProblemController()
        let markedProblems = SWMarkedProblemsController()
        let ownProblems = SWOwnProblemsController()
        
        let freshProblemImage = UIImage(named: "newIcon")
        let markedProblemImage = UIImage(named: "markedIcon")
        let ownProblemsimage = UIImage(named: "ownIcon")
        
        freshProblems.tabBarItem = UITabBarItem(title: nil, image: freshProblemImage, tag: 0)
        markedProblems.tabBarItem = UITabBarItem(title: nil, image: markedProblemImage, tag: 1)
        ownProblems.tabBarItem = UITabBarItem(title: nil, image: ownProblemsimage, tag: 2)

        
        tabBarController.viewControllers = [freshProblems, markedProblems, ownProblems]
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = tabBarController
        self.window?.makeKeyAndVisible()

        return true
    }
    
}


