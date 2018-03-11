//
//  SWMarkedProblemCell.swift
//  testTind
//
//  Created by Uladzislau Abramchuk on 11.03.2018.
//  Copyright © 2018 Uladzislau Abramchuk. All rights reserved.
//

import UIKit
class SWMarkedProblemCell: UITableViewCell {
    
    let problemImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.backgroundColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: -2, height: 2);
        view.layer.shadowRadius = 10.0
        view.layer.shadowOpacity = 0.3
//        view.layer.masksToBounds = true
//        view.layer.cornerRadius = 10.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    
    var problem: SWProblemObject? {
        didSet {
            if let problem = self.problem {
                updateUI(for: problem)
            }
        }
    }
    
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .clear
        selectionStyle = .none
        
        addSubview(containerView)
        containerView.addSubview(label)
        containerView.addSubview(problemImage)
        
        containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 60).isActive = true
        containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -60).isActive = true
        
        problemImage.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        problemImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        problemImage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        problemImage.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        label.heightAnchor.constraint(equalToConstant: 60).isActive = true
        label.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        label.topAnchor.constraint(equalTo: problemImage.bottomAnchor).isActive = true
        
    }
    
    
    private func updateUI(for problem: SWProblemObject) {
        label.text = problem.shortName
        problemImage.image = UIImage(data: problem.images.first!)
    }

    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}
