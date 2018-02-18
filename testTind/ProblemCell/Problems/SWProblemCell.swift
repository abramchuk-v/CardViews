//
//  ProblemCell.swift
//  testTind
//
//  Created by Uladzislau Abramchuk on 30.01.2018.
//  Copyright © 2018 Uladzislau Abramchuk. All rights reserved.
//

import UIKit

protocol MapViewTapDelegate {
    func didTappedMapView(center: CGPoint)
}

class SWProblemCell: UIView, SWImageAnimationDelegate {
    private var CORNER_RADIUS: CGFloat = 20.0
    var mapViewDelegate: MapViewTapDelegate?
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont(name: "Helvetica", size: 24)
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        textView.textColor = .black
        textView.backgroundColor = .clear
        textView.isSelectable = false
        return textView
    }()
    
    
    let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.hidesForSinglePage = true
        pageControl.backgroundColor = .clear
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .darkGray
        return pageControl
    }()
    
    
    let mapView: UIView = {
        let view = UIView()
        view.layer.contents = UIImage(named: "mapView")?.cgImage
        view.backgroundColor = .clear
        return view
    }()
    
    
    var collectionView: UICollectionView! 
    
    
    private let blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.prominent)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        return blurEffectView
    }()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setCollectionViewPosition()
        setPageControlPosition()
        setTextAndBlurPosition()
        setMapViewPosition()
        
        blurView.contentView.addSubview(textView)
        addSubview(collectionView)
        addSubview(pageControl)
        addSubview(blurView)
        addSubview(mapView)
        
        self.backgroundColor = .clear

        self.layer.masksToBounds = true
        self.layer.cornerRadius = CORNER_RADIUS
        
//        setWavyLineOfBlur()
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(mapViewTap))
        mapView.addGestureRecognizer(gesture)
    }
    
    
    

    
    //MARK: - Set views positiosns.
    
    private func setCollectionViewPosition() {
        let collectionViewLayout: SWPageLayout = SWPageLayout()
        collectionViewLayout.itemSize = CGSize(width: frame.width, height: frame.height)
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionViewLayout.minimumLineSpacing = 0
        collectionViewLayout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: CGRect(   x: bounds.origin.x,
                                                           y: bounds.origin.y,
                                                           width: frame.width,
                                                           height: frame.height),
                                          collectionViewLayout: collectionViewLayout)
        collectionView.decelerationRate = 0.99
        collectionView.backgroundColor = .white
        collectionView.register(SWImageCardForProblemCell.self, forCellWithReuseIdentifier: "ident")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight, .flexibleTopMargin, .flexibleBottomMargin, .flexibleLeftMargin, .flexibleRightMargin]
    }
    
    private func setPageControlPosition() {
        pageControl.frame = CGRect(x: bounds.origin.x,
                                   y: bounds.origin.y,
                                   width: bounds.width,
                                   height: bounds.height * 0.05)
        pageControl.autoresizingMask = [.flexibleTopMargin]
    }
    
    private func setTextAndBlurPosition() {
        blurView.frame = CGRect(x: bounds.origin.x, y: frame.height * 0.7, width: frame.width, height: frame.height * 0.3)
        blurView.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin, .flexibleLeftMargin, .flexibleRightMargin]
        
        textView.frame = blurView.contentView.frame
        textView.autoresizingMask = [.flexibleWidth, .flexibleTopMargin, .flexibleBottomMargin, .flexibleLeftMargin, .flexibleRightMargin]
    }
    
    private func setMapViewPosition() {
        mapView.center = CGPoint(x: blurView.frame.width - 50, y: blurView.frame.origin.y)
        mapView.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        mapView.autoresizingMask = [.flexibleRightMargin]
    }
    
    /** Make top line of blurView wavy.*/
    private func setWavyLineOfBlur() {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0.0, y: 10.0))
        path.addCurve(to: CGPoint(x: self.frame.width * 0.33, y: 10.0),
                      controlPoint1: CGPoint(x: self.frame.width * 0.11, y: -20.0),
                      controlPoint2: CGPoint(x: self.frame.width * 0.2, y: 40.0))
        
        path.addCurve(to: CGPoint(x: self.frame.width * 0.66, y: 10),
                      controlPoint1: CGPoint(x: self.frame.width * 0.44, y: -20.0),
                      controlPoint2: CGPoint(x: self.frame.width * 0.5, y: 40.0))
        path.addCurve(to: CGPoint(x: self.frame.width, y: 10),
                      controlPoint1: CGPoint(x: self.frame.width * 0.77, y: -20.0),
                      controlPoint2: CGPoint(x: self.frame.width * 0.8, y: 40.0))
        
        path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.size.height))
        path.addLine(to: CGPoint(x: 0.0, y: self.frame.size.height))
        
        path.close()
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        
        blurView.layer.mask = shapeLayer
    }
    
    
    
    
    
    //MARK: - Animatable part.
    /** After tap on image(scale it).*/
    func prepareImageIncreasing(completionHandler: @escaping () -> Void) {
        
        UIView.animate(withDuration: 0.2, animations: {
            self.pageControl.transform = self.pageControl.transform.translatedBy(x: 0, y: -self.pageControl.bounds.height)
            self.blurView.transform = self.blurView.transform.translatedBy(x: 0, y: self.blurView.bounds.height)
            self.mapView.bounds = CGRect(x: 0, y: 0, width: 0, height: 0)
        }) { (ens) in
            completionHandler()
        }
        
    }
    
    
    
    /** Set view to previous state(before tapping on image).*/
    func backToIdentity() {
        UIView.animate(withDuration: 0.15, delay: 0, options: .curveEaseInOut, animations: {

            self.transform = .identity
            self.pageControl.transform = .identity
            self.blurView.transform = .identity
            self.mapView.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        })
    }
    
    
    
    
    
    //MARK: - Actions for gesture.
    
    @objc private func mapViewTap() {
        self.mapViewDelegate?.didTappedMapView(center: self.convert(mapView.center, to: nil))
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

