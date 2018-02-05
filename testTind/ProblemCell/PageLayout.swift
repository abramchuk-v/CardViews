//
//  PageLayout.swift
//  PageLayout
//
//  Created by Uladzislau Abramchuk on 1/25/18.
//  Copyright © 2018 Uladzislau Abramchuk. All rights reserved.
//

import UIKit

public class PageLayout: UICollectionViewFlowLayout {
    
    override public func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        var layoutAttributes: Array = layoutAttributesForElements(in: collectionView!.bounds)!
        
        if layoutAttributes.count == 0 {
            return proposedContentOffset
        }
        
        var firstAttribute: UICollectionViewLayoutAttributes = layoutAttributes[0]
        
        if layoutAttributes.count == 1 {
            if velocity.x > 0 {
                return CGPoint(x: firstAttribute.center.x + collectionView!.bounds.size.width * 0.5, y: proposedContentOffset.y)
            } else if velocity.x < 0 {
                return CGPoint(x: firstAttribute.center.x - 1.5 * collectionView!.bounds.size.width , y: proposedContentOffset.y)
            }
        }
        
        for attribute: UICollectionViewLayoutAttributes in layoutAttributes {
            if attribute.representedElementCategory != .cell {
                continue
            }
            if velocity.x > 0.0 && attribute.center.x > firstAttribute.center.x {
                firstAttribute = attribute
            }else if ((velocity.x < 0.0 && attribute.center.x > firstAttribute.center.x)) {
                break
            } else if velocity.x == 0  && attribute.center.x == firstAttribute.center.x && proposedContentOffset.x > attribute.center.x {
                firstAttribute = attribute
                break
            } else if velocity.x == 0  && attribute.center.x > firstAttribute.center.x && proposedContentOffset.x < attribute.center.x {
                firstAttribute = attribute
                break
            }
        }
    
        return CGPoint(x: firstAttribute.center.x - collectionView!.bounds.size.width * 0.5, y: proposedContentOffset.y)
    }
}