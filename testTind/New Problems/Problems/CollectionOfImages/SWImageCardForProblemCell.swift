//
//  SWInsideCardCell.swift
//  testTind
//
//  Created by Uladzislau Abramchuk on 09.02.2018.
//  Copyright © 2018 Uladzislau Abramchuk. All rights reserved.
//

import UIKit

protocol SWImageAnimationDelegate: class {
    func prepareImageIncreasing(completionHandler: @escaping () -> Void)
    func backToIdentity()
}

class SWImageCardForProblemCell: UICollectionViewCell {
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var imageViewFrame: CGRect = CGRect.zero
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor =  .white
        self.layer.shouldRasterize = true
        addSubview(imageView)
        setPositionOfImageView()
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
