
//  SVSwipeCard.swift
//  testTind
//
//  Created by Uladzislau Abramchuk on 1/22/18.
//  Copyright © 2018 Uladzislau Abramchuk. All rights reserved.
//

import UIKit

protocol SwipeCardDelegate: class {
    func cardSwipedLeft(_ card: SwipeCard)
    func cardSwipedRight(_ card: SwipeCard)
    func cardTapped(_ card: SwipeCard)
}

class SwipeCard: UIView {
    
    var value: Any!
    
    weak var delegate: SwipeCardDelegate?
    /** Swipe left view.*/
    var leftOverlay: UIView? {
        didSet {
            leftOverlay?.autoresizingMask = [.flexibleBottomMargin, .flexibleLeftMargin, .flexibleRightMargin, .flexibleTopMargin]
        }
    }
    /** Swipe right view.*/
    var rightOverlay: UIView? {
        didSet {
            rightOverlay?.autoresizingMask = [.flexibleBottomMargin, .flexibleLeftMargin, .flexibleRightMargin, .flexibleTopMargin]
        }
    }
    
    
    private let marginForAction: CGFloat = 150.0
    private let rotationStrength: CGFloat = 320.0
    private let rotationAngle: CGFloat = 0.3
    private let rotationMax: CGFloat = 1
    private let scaleStrength: CGFloat = -2
    private let scaleMax: CGFloat = 1.15
    
    private var xFromCenter: CGFloat = 0.0
    private var yFromCenter: CGFloat = 0.0
    private var originalPoint = CGPoint.zero
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(dragEvent(gesture:)))
        self.addGestureRecognizer(panGesture)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapEvent(gesture:)))
        self.addGestureRecognizer(tapGesture)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /** Set overlays invisible.*/
    func configureOverlays() {
        self.configureOverlay(overlay: self.leftOverlay)
        self.configureOverlay(overlay: self.rightOverlay)
    }
    
    private func configureOverlay(overlay: UIView?) {
        if let overlay = overlay {
            self.addSubview(overlay)
            overlay.alpha = 0.0
        }
    }
    
    @objc func dragEvent(gesture: UIPanGestureRecognizer) {
        xFromCenter = gesture.translation(in: self).x
        yFromCenter = gesture.translation(in: self).y
        
        switch gesture.state {
        case .began:
            self.originalPoint = self.center
            break
        case .changed:
            let rStrength = min(xFromCenter / self.rotationStrength, rotationMax)
            let rAngle = self.rotationAngle * rStrength
            
            let scale = min(1 - fabs(rStrength) / self.scaleStrength, self.scaleMax)
            self.center = CGPoint(x: self.originalPoint.x + xFromCenter, y: self.originalPoint.y + yFromCenter)
            let transform = CGAffineTransform(rotationAngle: rAngle)
            let scaleTransform = transform.scaledBy(x: scale, y: scale)
            
            // can be some problems with animation, this block is called very often
            UIView.animate(withDuration: 0.05, animations: {
                self.transform = scaleTransform
            })
            self.updateOverlay(xFromCenter)
            break
        case .ended:
            self.afterSwipeAction()
            break
        default:
            break
        }
    }
    
    @objc func tapEvent(gesture: UITapGestureRecognizer) {
        self.delegate?.cardTapped(self)
    }
    
    /** Make action if Card out is going out of *marginForAction*. */
    private func afterSwipeAction() {
        if xFromCenter > marginForAction {
            self.rightAction()
        } else if xFromCenter < -marginForAction {
            self.leftAction()
        } else {
            UIView.animate(withDuration: 0.3) {
                self.center = self.originalPoint
                self.transform = CGAffineTransform.identity
                self.leftOverlay?.alpha = 0.0
                self.rightOverlay?.alpha = 0.0
            }
        }
    }
    
    /** Update overlay in time of paging.*/
    private func updateOverlay(_ distance: CGFloat) {
        var activeOverlay: UIView?
        if distance > 0 {
            self.leftOverlay?.alpha = 0.0
            activeOverlay = self.rightOverlay
        } else {
            self.rightOverlay?.alpha = 0.0
            activeOverlay = self.leftOverlay
        }
        
        activeOverlay?.alpha = min(fabs(distance)/150, 1.0)
    }
    
    private func rightAction() {
        let finishPoint = CGPoint(x: UIScreen.main.bounds.width + 500.0, y: 2.0 * yFromCenter + self.originalPoint.y)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.center = finishPoint
            self.alpha = 0.0
        }) { _ in
            self.removeFromSuperview()
        }
        
        self.delegate?.cardSwipedRight(self)
    }
    
    private func leftAction() {
        let finishPoint = CGPoint(x: -500.0, y: 2.0 * yFromCenter + self.originalPoint.y)
        UIView.animate(withDuration: 0.5, animations: {
            self.center = finishPoint
            self.alpha = 0.0
        }) { _ in
            self.removeFromSuperview()
        }
        self.delegate?.cardSwipedLeft(self)
    }
}



