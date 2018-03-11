//
//  ProblemCell.swift
//  testTind
//
//  Created by Uladzislau Abramchuk on 30.01.2018.
//  Copyright © 2018 Uladzislau Abramchuk. All rights reserved.
//

import UIKit

protocol ProblemTapDelegate: class {
    func didTappedMapView(center: CGPoint)
    func didTappedImage(viewController: UIViewController)
}

class SWProblemCell: UIView {
    
    private var CORNER_RADIUS: CGFloat = 35.0
    weak var mapViewDelegate: ProblemTapDelegate?
    
    
    var problem: SWProblemObject! {
        didSet {
            self.fullDescriptionLabel.text = problem.fullDescription
            self.shortNameLabel.text = problem.shortName
        }
    }

    private let fullDescriptionLabel: UILabel = {
        let textView = UILabel()
        textView.font = UIFont(name: "Helvetica", size: 24)
        textView.numberOfLines = 0
        textView.textColor = .black
        textView.backgroundColor = .clear
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private let shortNameLabel: UILabel = {
        let textView = UILabel()
        textView.font = UIFont(name: "Helvetica", size: 28)
        textView.numberOfLines = 1
        textView.textColor = .black
        textView.backgroundColor = .clear
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.hidesForSinglePage = true
        pageControl.backgroundColor = .clear
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .darkGray
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    
    let mapView: UIView = {
        let view = UIView()
        view.layer.contents = UIImage(named: "mapView")?.cgImage
        view.backgroundColor = .clear
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.6
        view.layer.shadowOffset = CGSize(width: -5.0, height: 3.0)
        view.layer.shadowRadius = 7
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    var collectionView: UICollectionView! 
    
    
    private let blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        return blurEffectView
    }()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
       
        configCollectionView()
        
        
        blurView.contentView.addSubview(fullDescriptionLabel)
        blurView.contentView.addSubview(shortNameLabel)
        addSubview(collectionView)
        addSubview(pageControl)
        addSubview(blurView)
        addSubview(mapView)
        
        setCollectionViewPosition()
        setTextAndBlurPosition()
        setPageControlPosition()
        setMapViewPosition()
        
        self.backgroundColor = .clear

        self.layer.masksToBounds = true
        self.layer.cornerRadius = CORNER_RADIUS
        
        corneredBlurVIew()
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(mapViewTap))
        mapView.addGestureRecognizer(gesture)
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    
    

    
    //MARK: - Set views positiosns.
    
    private func configCollectionView() {
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
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setCollectionViewPosition() {
        collectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    private func setPageControlPosition() {
        pageControl.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        pageControl.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    private func setTextAndBlurPosition() {
        blurView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -3).isActive = true
        blurView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 3).isActive = true
        blurView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -3).isActive = true
        blurView.heightAnchor.constraint(equalToConstant: self.frame.height * 0.3).isActive = true
    
        shortNameLabel.leadingAnchor.constraint(equalTo: blurView.leadingAnchor, constant: 10).isActive = true
        shortNameLabel.trailingAnchor.constraint(equalTo: mapView.leadingAnchor).isActive = true
        shortNameLabel.topAnchor.constraint(equalTo: blurView.topAnchor, constant: 10).isActive = true
        shortNameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        fullDescriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: blurView.bottomAnchor, constant: -10).isActive = true
        fullDescriptionLabel.leadingAnchor.constraint(equalTo: blurView.leadingAnchor, constant: 10).isActive = true
        fullDescriptionLabel.trailingAnchor.constraint(equalTo: blurView.trailingAnchor, constant: -10).isActive = true
        fullDescriptionLabel.topAnchor.constraint(equalTo: shortNameLabel.bottomAnchor, constant: 10).isActive = true
        
        
        
        blurView.layoutIfNeeded()
    }
    
    private func setMapViewPosition() {
        mapView.trailingAnchor.constraint(equalTo: blurView.trailingAnchor).isActive = true
        mapView.centerYAnchor.constraint(equalTo: blurView.topAnchor).isActive = true
        mapView.widthAnchor.constraint(equalTo: blurView.widthAnchor, multiplier: 0.23).isActive = true
        mapView.heightAnchor.constraint(equalTo: blurView.widthAnchor, multiplier: 0.23).isActive = true
    }
    
    /** Make different corner raduis of blurView.*/
    private func corneredBlurVIew() {
        let topRadius: CGFloat = 5.0
        let bottomRadius: CGFloat = CORNER_RADIUS - 3
        
        let minx = blurView.bounds.origin.x
        let miny = blurView.bounds.origin.y
        let maxx = blurView.bounds.width
        let maxy = blurView.bounds.height
        
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: maxx - bottomRadius, y: maxy))
        path.addLine(to: CGPoint(x: minx + bottomRadius, y: maxy))
        path.addArc(withCenter: CGPoint(x: minx + bottomRadius, y: maxy - bottomRadius), radius: bottomRadius, startAngle: CGFloat.pi / 2, endAngle: CGFloat.pi, clockwise: true)
        path.addLine(to: CGPoint(x: minx, y: miny + topRadius))
        path.addArc(withCenter: CGPoint(x: minx + topRadius, y: miny + topRadius), radius: topRadius, startAngle: CGFloat.pi, endAngle: 3 * CGFloat.pi / 2, clockwise: true)
        path.addLine(to: CGPoint(x: maxx - topRadius, y: miny))
        path.addArc(withCenter: CGPoint(x: maxx - topRadius, y: miny + topRadius), radius: topRadius, startAngle: 3 * CGFloat.pi / 2, endAngle: 0, clockwise: true)
        path.addLine(to: CGPoint(x: maxx, y: maxy - bottomRadius))
        path.addArc(withCenter: CGPoint(x: maxx - bottomRadius, y: maxy - bottomRadius), radius: bottomRadius, startAngle: 0, endAngle: CGFloat.pi / 2, clockwise: true)
        
        path.close()
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        
        blurView.layer.mask = shapeLayer
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
    
extension SWProblemCell: SWImageAnimationDelegate {
    
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
            self.mapView.bounds = CGRect(x: 0, y: 0, width: self.blurView.frame.width * 0.23, height: self.blurView.frame.width * 0.23)
        })
    }
    

    //MARK: - Actions for gesture.
    
    @objc private func mapViewTap() {
        self.mapViewDelegate?.didTappedMapView(center: self.convert(mapView.center, to: nil))
    }
}



extension SWProblemCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pageControl.numberOfPages = problem.images.count
        return problem.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ident", for: indexPath) as! SWImageCardForProblemCell
        cell.imageView.image = UIImage(data: problem.images[indexPath.row])
        return cell
    }
    
}

extension SWProblemCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    
    /**Select item*/
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let configuration = ImageViewerConfiguration { config in
            
            let imageW = (collectionView.cellForItem(at: indexPath) as! SWImageCardForProblemCell).imageView
            
            config.imageView = imageW
            ///////-----------FOR SOME IMAGE VIEW----------//////
            //            config.imageBlock = { loadBlock in
            //                print("1")
            //
            //                DispatchQueue.global(qos: .userInitiated).async {
            //                    let urlContents = try? Data(contentsOf: URL(string: "https://i.stack.imgur.com/GsDIl.jpg")!)
            //                    let image = UIImage(data: urlContents!)
            //                    loadBlock(image)
            //                }
            //            }
        }
        
        
        let imageViewerController = ImageViewerController(configuration: configuration)
        imageViewerController.animatableRealImageViewDelegate = self
        self.mapViewDelegate?.didTappedImage(viewController: imageViewerController)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageControl.currentPage = indexPath.row
    }
    
}

