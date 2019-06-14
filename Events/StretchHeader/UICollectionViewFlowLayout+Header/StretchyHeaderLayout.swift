//
//  StretchyHeaderLayout.swift
//  Character Collector
//
//  Created by Michael Briscoe on 2/6/17.
//  Copyright © 2017 Razeware, LLC. All rights reserved.
//

import UIKit

class StretchyHeaderLayout: UICollectionViewFlowLayout {
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    let layoutAttributes = super.layoutAttributesForElements(in: rect)! as [UICollectionViewLayoutAttributes]
    let offset = collectionView!.contentOffset
    print("contentOffset: ", offset)
    if (offset.y < 0) {
        let deltaY = abs(offset.y)
        print("deltaY: ", deltaY)
      for attributes in layoutAttributes {
        if let elementKind = attributes.representedElementKind {
            if elementKind == UICollectionView.elementKindSectionHeader {
            var frame = attributes.frame
            frame.size.height = max(0, headerReferenceSize.height + deltaY)
            frame.origin.y = frame.minY - deltaY
            attributes.frame = frame
          }
        }
      }
    }
    
    return layoutAttributes
  }

  override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
    return true
  }
  
  
  
  
  
  
  
  
  
  
  
  
  
}
