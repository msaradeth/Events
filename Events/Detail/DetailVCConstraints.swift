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
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    lazy var headerImage: UIImageView = {
        let headerImage = UIImageView(frame: .zero)
        headerImage.translatesAutoresizingMaskIntoConstraints = false
        headerImage.clipsToBounds = true
        headerImage.contentMode = UIView.ContentMode.scaleToFill    //.scaleAspectFill
        return headerImage
    }()
    lazy var dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        dateLabel.font = UIFont.systemFont(ofSize: 21, weight: .bold)
        return dateLabel
    }()
    lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.sizeToFit()
        descriptionLabel.numberOfLines = 0
        return descriptionLabel
    }()
    lazy var labelStackView: UIStackView = {
        let labelStackView = UIStackView()
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        labelStackView.axis = .vertical
        labelStackView.isLayoutMarginsRelativeArrangement = true
        labelStackView.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        return labelStackView
    }()    
    fileprivate let defaultHeight: CGFloat = 300
    var event: EventModel
    
    init(event: EventModel, delegate: ListViewModelService?) {
        self.event = event
        super.init(nibName: nil, bundle: nil)
        
        view.backgroundColor = .white
        dateLabel.text = event.date?.toLocalTime()
        descriptionLabel.text = event.description
        if let image = event.image {
            headerImage.image = image
        }else {
            headerImage.image = UIImage(named: "placeholder_nomoon")
            delegate?.loadImage(imageUrl: event.imageUrl, completion: { [weak self] (image) in
                DispatchQueue.main.async {
                    self?.headerImage.image = image ?? UIImage(named: "placeholder_nomoon")
                }
            })
        }
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
        stackView.addArrangedSubview(labelStackView)
        
        //label stackview
        labelStackView.addArrangedSubview(dateLabel)
        labelStackView.addArrangedSubview(descriptionLabel)
        
        //set Height of image and label
        headerImage.heightAnchor.constraint(equalToConstant: defaultHeight).isActive = true
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


