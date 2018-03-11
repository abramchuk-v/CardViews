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
    func getNewProblems(comletionHandler: @escaping ([SWProblemObject])->())
    func getMarkedProblems(comletionHandler: @escaping ([SWProblemObject])->())
}

class SWFirebaseProblemManager: SWProblemManager {
    
    
    
    private var previousRequest: Int?
    private var sizeOfStep: Int = 5
    private var isRepeatPart = false
    
    func getNewProblems(comletionHandler: @escaping ([SWProblemObject]) -> ()) {
        let reference = Database.database().reference().child("Problems").child("New")
        
        if let prevValue = previousRequest {
            reference
                .queryOrdered(byChild: "timestamp")
                .queryStarting(atValue: prevValue)
                .queryLimited(toFirst: UInt(sizeOfStep))
                .observe(.value) { (snapshot) in
                    
                    self.fillProblemArray(with: snapshot, comletionHandler: comletionHandler)
            }
            isRepeatPart = true
            
        } else {
            reference
                .queryOrdered(byChild: "timestamp")
                .queryLimited(toFirst: UInt(sizeOfStep) )
                .observe(.value) { (snapshot) in
                
                    self.fillProblemArray(with: snapshot, comletionHandler: comletionHandler)
//                    self.getNewProblems(comletionHandler: comletionHandler)
            }
        }
    }
    
    
    func getMarkedProblems(comletionHandler: @escaping([SWProblemObject]) -> ()) {
        let reference = Database.database().reference().child("Problems").child("New")
        
        if let prevValue = previousRequest {
            reference
                .queryOrdered(byChild: "timestamp")
                .queryStarting(atValue: prevValue)
                .queryLimited(toFirst: UInt(sizeOfStep))
                .observe(.value) { (snapshot) in
                    
                    self.fillProblemArray(with: snapshot, comletionHandler: comletionHandler)
            }
            isRepeatPart = true
            
        } else {
            reference
                .queryOrdered(byChild: "timestamp")
                .queryLimited(toFirst: UInt(sizeOfStep) )
                .observe(.value) { (snapshot) in
                    
                    self.fillProblemArray(with: snapshot, comletionHandler: comletionHandler)
            }
        }
    }
    
    
    private func fillProblemArray(with snapshot: DataSnapshot, comletionHandler: @escaping ([SWProblemObject])->()) {
        var arrOfProblems = [SWProblemObject]()
        if snapshot.value != nil {
            
            let imageGroup = DispatchGroup()
            let enumerator = snapshot.children
            
            while let rest = enumerator.nextObject() as? DataSnapshot {
                if isRepeatPart {
                    isRepeatPart = false
                    continue
                }
                DispatchQueue.global(qos: .userInitiated).async(group: imageGroup) {
                    if let problem = rest.value as? [String: Any],
                        let imagesURL = problem["images"] as? [String] {
                        let imagesData = imagesURL.flatMap {try? Data(contentsOf: URL(string: $0)!)}
                        arrOfProblems.append(SWProblemObject(images: imagesData,
                                                             shortName: problem["shortName"] as? String ?? "--",
                                                             views: problem["views"] as? Int ?? 0,
                                                             fullDescription: problem["fullDescription"] as? String ?? "--"
                        ))
                        
                    }
                }
                self.previousRequest = (rest.value as! [String: Any])["timestamp"] as? Int
            }
            
            imageGroup.notify(queue: .main, execute: {
                arrOfProblems.map{ print($0.shortName)}
                comletionHandler(arrOfProblems)
            })
        }
    }
}


////////////ADD///////////////
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

