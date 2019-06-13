//
//  Extensions.swift
//  Events
//
//  Created by Mike Saradeth on 6/12/19.
//  Copyright © 2019 Mike Saradeth. All rights reserved.
//

import Foundation
import UIKit


extension UIView {
    func fillsuperview() {
        guard let safeGuide = self.superview?.safeAreaLayoutGuide else { return }
        self.topAnchor.constraint(equalTo: safeGuide.topAnchor).isActive = true
        self.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: safeGuide.bottomAnchor).isActive = true
    }
}

