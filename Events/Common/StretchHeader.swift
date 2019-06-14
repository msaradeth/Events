//
//  StretchHeader.swift
//  Events
//
//  Created by Mike Saradeth on 6/13/19.
//  Copyright © 2019 Mike Saradeth. All rights reserved.
//

import UIKit

class StretchHeader: UIImageView {
    var maxHeight: CGFloat
    var minHeight: CGFloat
    var heightConstraint: NSLayoutConstraint!
    
    init(image: UIImage?, maxHeight: CGFloat, minHeight: CGFloat) {
        self.maxHeight = maxHeight
        self.minHeight = minHeight
        super.init(frame: .zero)
        self.image = image
        self.clipsToBounds = true
    }

    func anchorToSuperview() {
        guard let superview = self.superview else { return }
        self.translatesAutoresizingMaskIntoConstraints = false
        self.contentMode = .scaleAspectFill
        self.heightConstraint = self.heightAnchor.constraint(equalToConstant: maxHeight)
        self.topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
        NSLayoutConstraint.activate([heightConstraint])
    }
    
    func stretch(height: CGFloat) {
        heightConstraint.constant = height < minHeight ? minHeight : height
    }
    
    func setDefaulHeight(scrollView: UIScrollView) {
        var curHeight = heightConstraint.constant - scrollView.contentOffset.y
        if curHeight > maxHeight {
            curHeight = maxHeight
        }
        if curHeight < minHeight {
            curHeight = minHeight
        }
        heightConstraint.constant = curHeight
        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseIn, animations: {
            self.layoutIfNeeded()
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

