//
//  ProblemCell.swift
//  testTind
//
//  Created by Uladzislau Abramchuk on 30.01.2018.
//  Copyright © 2018 Uladzislau Abramchuk. All rights reserved.
//

import UIKit


class ProblemCell: UIView, ImageAnimateDelegate {
    
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
    
    var collectionView: UICollectionView!
    
    private let blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.prominent)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        return blurEffectView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear

        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10
        
        
        let collectionViewLayout: PageLayout = PageLayout()
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
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: "ident")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight, .flexibleTopMargin, .flexibleBottomMargin, .flexibleLeftMargin, .flexibleRightMargin]
        
        pageControl.frame = CGRect(x: bounds.origin.x,
                                   y: bounds.origin.y,
                                   width: bounds.width,
                                   height: bounds.height * 0.05)
        pageControl.autoresizingMask = [.flexibleTopMargin]
        
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight, .flexibleTopMargin, .flexibleLeftMargin, .flexibleRightMargin]
        
        blurView.frame = CGRect(x: bounds.origin.x, y: frame.height * 0.7, width: frame.width, height: frame.height * 0.3)
        textView.frame = blurView.contentView.frame
        textView.autoresizingMask = [.flexibleWidth, .flexibleTopMargin, .flexibleBottomMargin, .flexibleLeftMargin, .flexibleRightMargin]
        blurView.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin, .flexibleLeftMargin, .flexibleRightMargin]
        
        blurView.contentView.addSubview(textView)
        addSubview(collectionView)
        addSubview(pageControl)
        addSubview(blurView)
    }
    
    
    func prepareImageIncreasing(completionHandler: @escaping () -> Void) {
//        let newCenter = blurView.frame.origin.y + blurView.frame.height
        
        
//        let currentFrame = self.convert(self.bounds, to: nil)
//        let rootView = UIApplication.shared.keyWindow?.rootViewController?.view
//        rootView?.addSubview(self)
//
//
//        self.frame = currentFrame

        
        
        UIView.animate(withDuration: 0.35, animations: {
//            let centr = rootView?.convert((rootView?.center)!, to: self)
//            self.center = centr!
            self.layer.cornerRadius = 0
            

            let xScale = (UIScreen.main.bounds.width / self.bounds.width)
            let yScale = (UIScreen.main.bounds.height / self.bounds.height)
            self.transform = self.transform.scaledBy(x: xScale, y: yScale)
            // here some magic, I don't know why "-18"
            self.transform = self.transform.translatedBy(x: 0, y: -18)

//            self.frame = UIScreen.main.bounds

            
            self.pageControl.transform = self.pageControl.transform.translatedBy(x: 0, y: -self.pageControl.bounds.height)
            self.blurView.transform = self.blurView.transform.translatedBy(x: 0, y: self.blurView.bounds.height)
        }) { (ens) in
//            completionHandler()
        }
        
    }
    
    func prepareImageReducing() {
        UIView.animate(withDuration: 0.19) {
            self.layer.cornerRadius = 10
            self.transform = .identity
            // add to superView
            
            self.pageControl.transform = .identity
            self.blurView.transform = .identity
//            self.pageControl.center = CGPoint(x: 177.0, y: self.bounds.height * 0.05)
//            self.blurView.center = CGPoint(x: 177.0, y: 557.6)
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class CustomCell: UICollectionViewCell {
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var imageViewFrame: CGRect = CGRect.zero
    var animateDelegate: ImageAnimateDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor =  .white
        self.layer.shouldRasterize = true
        addSubview(imageView)
        
        setPositionOfImageView()
        
        let longGest = UILongPressGestureRecognizer(target: self, action: #selector(increaseImage(gesture:)))
        longGest.minimumPressDuration = 0.3
        longGest.numberOfTouchesRequired = 1
        self.addGestureRecognizer(longGest)
    }
    
    @objc private func increaseImage(gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            
            self.animateDelegate?.prepareImageIncreasing { [weak self] in
                
                let frame = self?.convert((self?.imageView.frame)!, to: nil)
                self?.imageViewFrame = frame!
                
                let window = UIApplication.shared.keyWindow?.rootViewController?.view
                
                self?.imageView.center = (window?.center)!
                self?.imageView.frame = (self?.imageViewFrame)!
                window?.addSubview((self?.imageView)!)
                
                
                UIView.animate(withDuration: 0.3, animations: { [weak self] in
                    self?.imageView.layer.cornerRadius = 0
                    self?.imageView.frame = (window?.frame)!
                })
            }
            
            
            
            
        // animate image reducing
        case .ended:
            
//            UIView.animate(withDuration: 0.3, animations: { [weak self] in
//                self?.imageView.frame = (self?.imageViewFrame)!
//                self?.imageView.layer.cornerRadius = 10
//                }, completion: { isEnd in
//                    self.addSubview(self.imageView)
//                    self.setPositionOfImageView()
                    self.animateDelegate?.prepareImageReducing()
//            })
        
        default:
            break
        }
    }
    
    private func setPositionOfImageView() {
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("ERRROR")
    }
}

