//
//  MenuView.swift
//  Events
//
//  Created by Mike Saradeth on 6/13/19.
//  Copyright © 2019 Mike Saradeth. All rights reserved.
//

import UIKit

class MenuView: UIView {
    lazy var backButton: UIImageView = {
        let backButton = UIImageView(image: UIImage(named: "share"))
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
        backButton.isUserInteractionEnabled = true
        backButton.clipsToBounds = true
        return backButton
    }()
    
    lazy var shareButton: UIImageView = {
        let backButton = UIImageView(image: UIImage(named: "share"))
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
        backButton.isUserInteractionEnabled = true
        backButton.clipsToBounds = true
        return backButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setupSubviews()
    }
    
    func anchorToSuperview() {
        guard let safeGuide = self.superview else { return }
        topAnchor.constraint(equalTo: safeGuide.topAnchor, constant: 40).isActive = true
        leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor).isActive = true
    }
    
    private func setupSubviews() {
        addSubview(backButton)
        backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        backButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(shareButton)
        shareButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        shareButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
