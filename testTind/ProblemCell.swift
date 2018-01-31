//
//  ProblemCell.swift
//  testTind
//
//  Created by Uladzislau Abramchuk on 30.01.2018.
//  Copyright © 2018 Uladzislau Abramchuk. All rights reserved.
//

import UIKit

class ProblemCell: UIView {
    
    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 24)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    var collectionView: UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        self.layer.borderWidth = 0.3
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: -5.0, height: 5.0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 1.0
        self.layer.cornerRadius = 10
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
        self.layer.shouldRasterize = true
        
        
        label.frame = CGRect(x: 20, y: frame.height - 80, width: frame.width - 40, height: 40)
        label.autoresizingMask = [.flexibleBottomMargin, .flexibleLeftMargin, .flexibleRightMargin, .flexibleTopMargin, .flexibleHeight, .flexibleWidth]
        
        let collectionViewLayout: PageLayout = PageLayout()
        collectionViewLayout.itemSize = CGSize(width: frame.width - 50, height: frame.height * 0.9)
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 100, right: 10)
        
        collectionViewLayout.minimumLineSpacing = 40
        
        collectionViewLayout.scrollDirection = UICollectionViewScrollDirection.horizontal
        
        collectionView = UICollectionView(frame: CGRect(x: bounds.origin.x + 10,
                                                        y: bounds.origin.y + 20,
                                                        width: frame.width - 20,
                                                        height: frame.height - 40),
                                          collectionViewLayout: collectionViewLayout)
        
        collectionView.backgroundColor = .white
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: "ident")
        
        addSubview(collectionView)
        addSubview(label)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class CustomCell: UICollectionViewCell {
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor =  .white
//        self.layer.shadowColor = UIColor.lightGray.cgColor
//        self.layer.shadowOffset = CGSize(width: -5.0, height: 5.0)
//        self.layer.shadowRadius = 2.0
//        self.layer.shadowOpacity = 1.0
//        self.layer.cornerRadius = 8
//        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
        
        addSubview(imageView)
        
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("ERRROR")
    }
}

