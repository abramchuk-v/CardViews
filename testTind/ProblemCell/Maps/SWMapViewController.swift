//
//  MapViewController.swift
//  testTind
//
//  Created by Uladzislau Abramchuk on 11.02.2018.
//  Copyright © 2018 Uladzislau Abramchuk. All rights reserved.
//

import MapKit
class SWMapViewController: UIViewController {
    
    private var mapView: SWMapView = SWMapView()
    
    private var backButton: UIButton { return mapView.backButton }
    var snapView: UIView!
    
    override func loadView() {
        super.loadView()
        mapView.frame = self.view.frame
        
        snapView = UIView(frame: self.view.frame)
        self.view.addSubview(snapView)
        
        self.view.addSubview(mapView)
        
        
    }
    
    init(string: String) {
        super.init(nibName: nil, bundle: nil)
        print(string)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
//        self.view.backgroundColor = .green
        mapView.mapView.delegate = self
//        self.snapView = mapView.mapView.snapshotView(afterScreenUpdates: true)
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
    }
    
    @objc func back() {
        dismiss(animated: true, completion: nil)
    }
}

extension SWMapViewController: MKMapViewDelegate {
 
}
