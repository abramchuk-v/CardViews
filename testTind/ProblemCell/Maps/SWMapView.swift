//
//  MapView.swift
//  testTind
//
//  Created by Uladzislau Abramchuk on 11.02.2018.
//  Copyright © 2018 Uladzislau Abramchuk. All rights reserved.
//

import MapKit

class SWMapView: UIView {
    
    let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.mapType = .standard
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "closeImage"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(mapView)
        addSubview(backButton)

        setMapConstraint()

        backButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 32).isActive = true
        backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setMapConstraint() {
        mapView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        mapView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        mapView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        mapView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
