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
    var heightConstraint: NSLayoutConstraint!
    
    init(image: UIImage?, maxHeight: CGFloat) {
        self.maxHeight = maxHeight
        super.init(frame: .zero)
        self.image = image
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
    
    func stretch(scrollview: UIScrollView) {
        let curHeight = heightConstraint.constant - scrollview.contentOffset.y
        heightConstraint.constant = curHeight        
    }
    
    func setHeight(scrollView: UIScrollView) {
        var curHeight = heightConstraint.constant - scrollView.contentOffset.y
        if curHeight > maxHeight {
            curHeight = maxHeight
        }
        if curHeight < 0 {
            curHeight = 0
        }

        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseIn, animations: {
            self.heightConstraint.constant = curHeight
            self.layoutIfNeeded()
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

