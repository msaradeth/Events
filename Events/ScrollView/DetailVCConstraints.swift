//
//  DetailVCConstraints.swift
//  Events
//
//  Created by Mike Saradeth on 6/17/19.
//  Copyright © 2019 Mike Saradeth. All rights reserved.
//

import Foundation
import UIKit

class DetailVCConstraints: UIViewController {
    let text = "Sure enough, Swift’s new video ends with her wearing a fries costume while her onetime nemesis pops up in the burger costume she famously wore to the Met Gala after-party. As the characters around them have a food fight, Swift and Perry slowly walk towards one another and embrace. The video ends with Swift singing “you need to calm down” one last time while Perry flashes her a smile.  \nSure enough, Swift’s new video ends with her wearing a fries costume while her onetime nemesis pops up in the burger costume she famously wore to the Met Gala after-party. As the characters around them have a food fight, Swift and Perry slowly walk towards one another and embrace. The video ends with Swift singing “you need to calm down” one last time while Perry flashes her a smile. \nSure enough, Swift’s new video ends with her wearing a fries costume while her onetime nemesis pops up in the burger costume she famously wore to the Met Gala after-party. As the characters around them have a food fight, Swift and Perry slowly walk towards one another and embrace. The video ends with Swift singing “you need to calm down” one last time while Perry flashes her a smile. \n Sure enough, Swift’s new video ends with her wearing a fries costume while her onetime nemesis pops up in the burger costume she famously wore to the Met Gala after-party. As the characters around them have a food fight, Swift and Perry slowly walk towards one another and embrace. The video ends with Swift singing “you need to calm down” one last time while Perry flashes her a smile. \nSure enough, Swift’s new video ends with her wearing a fries costume while her onetime nemesis pops up in the burger costume she famously wore to the Met Gala after-party. As the characters around them have a food fight, Swift and Perry slowly walk towards one another and embrace. The video ends with Swift singing “you need to calm down” one last time while Perry flashes her a smile. \nSure enough, Swift’s new video ends with her wearing a fries costume while her onetime nemesis pops up in the burger costume she famously wore to the Met Gala after-party. As the characters around them have a food fight, Swift and Perry slowly walk towards one another and embrace. The video ends with Swift singing “you need to calm down” one last time while Perry flashes her a smile."
    
    
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delegate = self
        scrollView.alwaysBounceVertical = true
        scrollView.backgroundColor = .white
        return scrollView
    }()
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    let headerImage: UIImageView = {
        let headerImage = UIImageView(frame: .zero)
        headerImage.translatesAutoresizingMaskIntoConstraints = false
        headerImage.clipsToBounds = true
        headerImage.contentMode = UIView.ContentMode.scaleToFill    //.scaleAspectFill
        return headerImage
    }()
    let dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        dateLabel.font = UIFont.systemFont(ofSize: 21, weight: .bold)
        return dateLabel
    }()
    let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.sizeToFit()
        descriptionLabel.numberOfLines = 0
        return descriptionLabel
    }()
    var event: EventModel
    let defaultHeight: CGFloat = 300
    var headerHeightConstraint: NSLayoutConstraint
    
    init(event: EventModel) {
        self.event = event
        headerHeightConstraint = headerImage.heightAnchor.constraint(equalToConstant: defaultHeight)
        NSLayoutConstraint.activate([headerHeightConstraint])
        super.init(nibName: nil, bundle: nil)
        
        view.backgroundColor = .white
        headerImage.image = event.image
        dateLabel.text = event.date?.toLocalTime()
        descriptionLabel.text = event.description
        
        setupViews()
    }

    func setupViews() {
        //Add scrollveiw to mainview
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        
        //stackview to scrollview - auto dynamic contentsize
        scrollView.addSubview(stackView)
        stackView.fillSuperview()
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        //Add views to stackview
        stackView.addArrangedSubview(headerImage)
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(descriptionLabel)
        
        //Set description length
        descriptionLabel.heightAnchor.constraint(equalToConstant: descriptionLabel.getHeight(width: stackView.bounds.width))
        view.layoutIfNeeded()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension DetailVCConstraints: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            let offset = abs(scrollView.contentOffset.y)
            let xStretch = offset * 0.5
            headerImage.frame = CGRect(x: -xStretch, y: -offset, width: scrollView.bounds.size.width + (2 * xStretch), height: defaultHeight + offset)
        } else {
            headerImage.frame = CGRect(x: 0, y: 0, width: scrollView.bounds.size.width, height: defaultHeight)
        }
    }
}

