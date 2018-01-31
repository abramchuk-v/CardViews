//
//  ViewController.swift
//  testTind
//
//  Created by Uladzislau Abramchuk on 1/18/18.
//  Copyright © 2018 Uladzislau Abramchuk. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource {
    
    private var cardView: SwipeCardsView!
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
        
        self.view.backgroundColor = .white
        
        let frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        cardView = SwipeCardsView(frame: frame)
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.delegate = self
        cardView.dataSource = self
        self.view.addSubview(cardView)
        
        cardView.autoresizingMask = [.flexibleBottomMargin, .flexibleLeftMargin, .flexibleRightMargin, .flexibleTopMargin, .flexibleHeight, .flexibleWidth]
        
        cardView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: SwipeCardViewDelegate {
    func nearOfEnd() {
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
extension ViewController: SwipeCardViewDataSource {
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

        let cell = ProblemCell(frame: CGRect(x: 30, y: 20, width: frame.width - 60, height: frame.height - 40))
//        cell.imageView.image = images[index]
        cell.label.text = "\(index)"
        cell.collectionView.dataSource = self
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images1.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ident", for: indexPath) as! CustomCell
        cell.imageView.image = images1[indexPath.row]
        return cell
    }
}

