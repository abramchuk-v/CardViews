//
//  SWProblemObject.swift
//  testTind
//
//  Created by Uladzislau Abramchuk on 02.03.2018.
//  Copyright © 2018 Uladzislau Abramchuk. All rights reserved.
//

import UIKit

class SWProblemObject {
    let images: [UIImage]
    let shortName: String
    let views: Int
    let fullDescription: String
    
    
    init(images: [UIImage], shortName: String, views: Int, fullDescription: String) {
        self.images = images
        self.shortName = shortName
        self.views = views
        self.fullDescription = fullDescription
    }
}
