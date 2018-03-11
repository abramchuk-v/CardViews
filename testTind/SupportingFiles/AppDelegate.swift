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

        let problemManager = SWFirebaseProblemManager()
        
        
        let tabBarController = UITabBarController()
        tabBarController.tabBar.barTintColor = .white
        tabBarController.tabBar.layer.borderColor = UIColor.clear.cgColor
        tabBarController.tabBar.clipsToBounds = true
        
        let freshProblems = SWFreshProblemController(problemManger: problemManager)
        
        let markedAssembly = SWMarkedAssemly(problemManager: problemManager)
        let navigationController = UINavigationController(rootViewController: markedAssembly.vc)
        navigationController.hidesBarsOnSwipe = true
        
        
        let ownProblems = SWOwnProblemsController()
        
        let freshProblemImage = UIImage(named: "newIcon")
        let markedProblemImage = UIImage(named: "markedIcon")
        let ownProblemsimage = UIImage(named: "ownIcon")
        
        freshProblems.tabBarItem = UITabBarItem(title: nil, image: freshProblemImage, tag: 0)
        markedAssembly.vc.tabBarItem = UITabBarItem(title: nil, image: markedProblemImage, tag: 1)
        ownProblems.tabBarItem = UITabBarItem(title: nil, image: ownProblemsimage, tag: 2)

        
        tabBarController.viewControllers = [freshProblems, navigationController, ownProblems]
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = tabBarController
        self.window?.makeKeyAndVisible()

        return true
    }
    
}


