//
//  SWProblemManager.swift
//  testTind
//
//  Created by Uladzislau Abramchuk on 02.03.2018.
//  Copyright © 2018 Uladzislau Abramchuk. All rights reserved.
//

import Foundation
import Firebase
protocol SWProblemManager {
    func getProblems() -> [SWProblemObject]
}

class SWFirebaseProblemManager: SWProblemManager {
    
    private var countOfRequest: Int = 0
    private var sizeOfStep: Int = 10
    
    func getProblems() -> [SWProblemObject] {
        let arrOfProblems = [SWProblemObject]()
        let reference = Database.database().reference().child("Problems").child("New")
//        reference.setValue("asf")
        
//        let values = ["shortName": "Problem 13",
//                      "timestamp": ServerValue.timestamp(),
//                      "fullDescription" : "To enabln getProblems() -> [SWProblemObject] {: -FIRAnalytics asdg 90usd iuasn knjasjk jksk",
//                      "images" : ["https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTxc2TA0ePCKxxKusXBD4Eno831j-zkrZdtdYahzK31u5BJPhV", "https://comps.canstockphoto.com/joystick-sketch-icon-vector-clipart_csp44989308.jpg"],
//                      "views" : 1512] as [String : Any]
//        let values1 = ["shortName": "Problem 14",
//                      "timestamp": ServerValue.timestamp(),
//                      "fullDescription" : "VLE SASKE alyticsDebugEnabled (see ht reference.childByAutoId().updateChildValues(values1) { (err, ref) in",
//                      "images" : [ "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRoBhhfxNYE-E4WvOBl5uJHUth0LLP3hEhYcc1e3DQIQNHrrO9i", "https://comps.canstockphoto.com/joystick-sketch-icon-vector-clipart_csp44989308.jpg", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTxc2TA0ePCKxxKusXBD4Eno831j-zkrZdtdYahzK31u5BJPhV"],
//                      "views" : 87] as [String : Any]
//
//        reference.childByAutoId().updateChildValues(values) { (err, ref) in
//
//            if let err = err {
//                print("failed to upload user data", err)
//                return
//            }
//
//        }
//
//        reference.childByAutoId().updateChildValues(values1) { (err, ref) in
//
//            if let err = err {
//                print("failed to upload user data", err)
//                return
//            }
//
//        }
        
        //////////////////////////asfasf/////////
        
//        reference
//            .queryOrdered(byChild: "timestamp")
//            .queryLimited(toFirst: 5)
//            .observe(.value) { (snapshot) in
//                let arr = snapshot.value as? [String: [String: Any]]
//                print(arr!["-L6bK7mhY-fz2rkLiS9X"])
//
//
//                reference
//                    .queryOrdered(byChild: "timestamp")
//                    .queryStarting(atValue: arr!["-L6bK7mhY-fz2rkLiS9X"]?["timestamp"])
//                    .queryEnding(atValue: 1520004648611)
//                    .observe(.value) { (snapshot) in
//                    let arr = snapshot.value as? [String: [String: Any]]
//                    print(arr?.count)
//                }
//        }
        
        
        countOfRequest += 1
        return arrOfProblems
    }
}
