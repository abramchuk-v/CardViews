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
    private var pageControl: UIPageControl?
    
    private var animatableRealImageView: SWImageAnimationDelegate?
    
    private var mapAnimationCenter = CGPoint.zero
    
    
    var images: [UIImage] = [
                             UIImage(named: "\(0)")!,
                             UIImage(named: "\(1)")!,
                             UIImage(named: "\(2)")!,
                             UIImage(named: "\(3)")!,
                             UIImage(named: "\(4)")!,
                             UIImage(named: "\(5)")!,
                             UIImage(named: "\(6)")!
                            ]
    var images1: [UIImage] = [
        UIImage(named: "\(0)")!,
        UIImage(named: "\(1)")!,
        UIImage(named: "\(2)")!,
        UIImage(named: "\(3)")!,
        UIImage(named: "\(4)")!,
        UIImage(named: "\(5)")!,
        UIImage(named: "\(6)")!
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        cardView.delegate = self
        cardView.dataSource = self
        cardView.bufferSize = 1
        
        
        cardView.reloadData()
        
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
            cardView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor, constant: -16).isActive = true
            cardView.bottomAnchor.constraint(equalTo: self.self.view.layoutMarginsGuide.bottomAnchor, constant: -16).isActive = true
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
        // here load all objects
        images += images1
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
        return images.count
    }
    
    func createViewForCard(index: Int, with frame: CGRect) -> UIView {
        let cell = SWProblemCell(frame: CGRect(x: 30, y: 10, width: frame.width - 60, height: frame.height - 20))
        cell.textView.text = "\(index)"
        cell.collectionView.dataSource = self
        cell.collectionView.delegate = self
        pageControl = cell.pageControl
        
        // Set animatable delegate to *ImageViewerController*
        cell.mapViewDelegate = self
        animatableRealImageView = cell
        
        
        let attributedString = NSMutableAttributedString(string: "Самый простой\n пример текста для какого-то левлого приложения вместе с текст вью ьбудет ли он исчезать при переборе текста на определенные границы границы европы украниа я не выкупаб по российску вот так вот на на на неще пожвлуйста пару строчек придумай Влад, ладно все хватит\n\n")
        
        let attributes0: [NSAttributedStringKey : Any] = [
            .font: UIFont(name: "HelveticaNeue-Bold", size: 15)!
        ]
        attributedString.addAttributes(attributes0, range: NSRange(location: 0, length: 13))
        
        let attributes2: [NSAttributedStringKey : Any] = [
            .font: UIFont(name: "HelveticaNeue-Bold", size: 13)!
        ]
        attributedString.addAttributes(attributes2, range: NSRange(location: 51, length: 10))
        
        cell.textView.attributedText = attributedString
        return cell
    }
    
}


extension SWFreshProblemController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pageControl?.numberOfPages = images1.count
        return images1.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ident", for: indexPath) as! SWImageCardForProblemCell
        cell.imageView.image = images1[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageControl?.currentPage = indexPath.row
    }
    
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
        imageViewerController.animatableRealImageViewDelegate = self.animatableRealImageView
        
        present(imageViewerController, animated: true)
    }
    
}

extension SWFreshProblemController: MapViewTapDelegate {
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


