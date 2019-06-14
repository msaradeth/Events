//
//  Extensions.swift
//  Events
//
//  Created by Mike Saradeth on 6/12/19.
//  Copyright © 2019 Mike Saradeth. All rights reserved.
//

import Foundation
import UIKit
import MessageUI


extension UINavigationBar {
    func transparent() {
        setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        shadowImage = UIImage()
    }
    func visible() {
        setBackgroundImage(nil, for: .default)
        shadowImage = nil
    }
}

extension UIView {
    func fillsuperview() {
        guard let safeGuide = self.superview?.safeAreaLayoutGuide else { return }
        self.topAnchor.constraint(equalTo: safeGuide.topAnchor).isActive = true
        self.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: safeGuide.bottomAnchor).isActive = true
    }
}


extension String {
    //convert UTC GMT to local time       
    func toLocalTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        if let date = dateFormatter.date(from: self) {
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
            return dateFormatter.string(from: date)
        }else {
            return ""
        }
    }
}

