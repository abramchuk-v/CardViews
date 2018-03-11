//
//  ViewController.swift
//  testTind
//
//  Created by Uladzislau Abramchuk on 1/18/18.
//  Copyright © 2018 Uladzislau Abramchuk. All rights reserved.
//

import UIKit

class SWFreshProblemController: UIViewController {
    
    
    private let transition = SWScaleTransition()
    private var cardView: SwipeCardsView!
    
    private var mapAnimationCenter = CGPoint.zero
    private var problemManager: SWProblemManager
    
    private var problems = [SWProblemObject]()
    
    init(problemManger: SWProblemManager) {
        self.problemManager = problemManger
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardView.delegate = self
        cardView.dataSource = self
        cardView.bufferSize = 1
        
        problemManager.getNewProblems { [weak self] (problems) in
            self?.problems.append(contentsOf: problems)
            self?.cardView.reloadData()
        }
    }

    override func loadView() {
        super.loadView()
        self.view.backgroundColor = .white
        cardView = SwipeCardsView()
        cardView.translatesAutoresizingMaskIntoConstraints  = false
        
        
        self.view.addSubview(cardView)
        
        
        
        if #available(iOS 11.0, *) {
            cardView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
            cardView.bottomAnchor.constraint(equalTo: self.self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        } else {
            cardView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor, constant: 16).isActive = true
            cardView.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor, constant: -46).isActive = true
        }
        cardView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        cardView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        cardView.autoresizingMask = [.flexibleBottomMargin, .flexibleLeftMargin, .flexibleRightMargin, .flexibleTopMargin, .flexibleHeight, .flexibleWidth]
        self.view.layoutIfNeeded()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension SWFreshProblemController: SwipeCardViewDelegate {
    func nearOfEnd() {
        problemManager.getNewProblems { [weak self] (problems) in
            self?.problems.append(contentsOf: problems)
        }
    }
    
    func swipedLeft(_ object: Any) {
        print(object)
    }
    
    func swipedRight(_ object: Any) {
        print(object)
    }
    
    func cardTapped(_ object: Any) {
        print("KLAC")
    }
    
    func reachedEnd() {
        print("End")
    }
}
extension SWFreshProblemController: SwipeCardViewDataSource {
    func createViewForOverlay(index: Int, swipe: SwipeMode, with frame: CGRect) -> UIView {
        let label = UILabel()
        label.frame.size = CGSize(width: 100, height: 100)
        label.center = CGPoint(x: frame.width / 2, y: frame.height / 2)
        label.layer.cornerRadius = label.frame.width / 2
        label.backgroundColor = swipe == .left ? UIColor.red : UIColor.green
        label.clipsToBounds = true
        label.text = swipe == .right ? "👍" : "👎"
        label.font = UIFont.systemFont(ofSize: 24)
        label.textAlignment = .center
        return label
    }
    
    
    
    func rowCount() -> Int {
        return problems.count
    }
    
    func createViewForCard(index: Int, with frame: CGRect) -> UIView {
        let cell = SWProblemCell(frame: CGRect(x: 30, y: 10, width: frame.width - 60, height: frame.height - 20))
        cell.problem = problems[index]
        
        // Set animatable delegate to *ImageViewerController*
        cell.mapViewDelegate = self
        
        
        
        return cell
    }
    
}

extension SWFreshProblemController: ProblemTapDelegate {
    func didTappedImage(viewController: UIViewController) {
        present(viewController, animated: true)
    }
    
    func didTappedMapView(center: CGPoint) {
        
        // pass here some data
        
        let vc = SWMapViewController(string: "ssssssss")
        
        
        vc.transitioningDelegate = self
        vc.modalPresentationStyle = .overCurrentContext
        self.mapAnimationCenter = center
        self.present(vc, animated: true, completion: nil)
    }
}

extension SWFreshProblemController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = mapAnimationCenter
        transition.bubbleColor = UIColor(hexString: "#F8F5EE")
        return transition
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = mapAnimationCenter
        transition.bubbleColor = UIColor(hexString: "#F8F5EE")
        return transition
    }
}


