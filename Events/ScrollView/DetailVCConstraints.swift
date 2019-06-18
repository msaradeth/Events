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
        //        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delegate = self
        scrollView.bounces = true
        scrollView.backgroundColor = .white
        return scrollView
    }()
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = UIStackView.Distribution.fillProportionally
        stackView.axis = .vertical
        return stackView
    }()
    let headerImage: UIImageView = {
        let headerImage = UIImageView(frame: .zero)
        //        headerImage.translatesAutoresizingMaskIntoConstraints = false
        headerImage.clipsToBounds = true
        headerImage.contentMode = UIView.ContentMode.scaleToFill    //.scaleAspectFill
        return headerImage
    }()
    let dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
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
        self.headerHeightConstraint = headerImage.heightAnchor.constraint(equalToConstant: defaultHeight)
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
        headerImage.image = event.image
        dateLabel.text = event.date?.toLocalTime()
        descriptionLabel.text = text
        
    }
    
    let headerView = UIImageView()
    let footerView = UIView()
    
    
    override func viewWillAppear(_ animated: Bool) {
        setupSubviews()
    }
    
    func setupSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        scrollView.frame = view.frame
        //        stackView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 2000)
        
        headerImage.frame = CGRect(x: 0, y: 0, width: scrollView.frame.width, height: defaultHeight)
        //        dateLabel.frame = CGRect(x: 0, y: 0, width: scrollView.frame.width, height: 40)
        //        descriptionLabel.frame = CGRect(x: 0, y: 0, width: scrollView.frame.width, height: 500)
        
        //        let height = headerImage.bounds.height + dateLabel.bounds.height + descriptionLabel.bounds.height
        //        let contentHeight = height > view.bounds.height ? height : view.frame.height
        //        scrollView.contentSize = CGSize(width: scrollView.bounds.width , height: stackView.frame.height)
        
        scrollView.autoresizingMask = [.flexibleWidth]
        stackView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        //        headerImage.autoresizingMask = [.flexibleWidth]
        //        dateLabel.autoresizingMask = [.flexibleWidth]
        //        descriptionLabel.autoresizingMask = [.flexibleWidth]
        
        stackView.addArrangedSubview(headerImage)
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        print(stackView.frame.height)
        print(stackView.frame.width)
        
        scrollView.contentSize = CGSize(width: scrollView.bounds.width , height: 2000)
        
        
        view.layoutIfNeeded()
    }
    
    func setupSubviews2() {
        view.addSubview(scrollView)
        scrollView.addSubview(headerImage)
        scrollView.addSubview(dateLabel)
        scrollView.addSubview(descriptionLabel)
        
        scrollView.frame = view.frame
        headerImage.frame = CGRect(x: 0, y: 0, width: scrollView.frame.width, height: defaultHeight)
        dateLabel.frame = CGRect(x: 0, y: headerImage.frame.maxY, width: scrollView.frame.width, height: 40)
        
        descriptionLabel.text = text
        descriptionLabel.numberOfLines = 0
        descriptionLabel.sizeToFit()
        print(descriptionLabel.frame.height)
        let labelHeight = descriptionLabel.frame.height
        descriptionLabel.frame = CGRect(x: 0, y: dateLabel.frame.maxY, width: scrollView.frame.width, height: 500)
        
        let height = headerImage.bounds.height + dateLabel.bounds.height + descriptionLabel.bounds.height
        let contentHeight = height > view.bounds.height ? height : view.frame.height
        scrollView.contentSize = CGSize(width: scrollView.bounds.width , height: 2000)
        
        scrollView.autoresizingMask = [.flexibleWidth]
        headerImage.autoresizingMask = [.flexibleWidth]
        dateLabel.autoresizingMask = [.flexibleWidth]
        descriptionLabel.autoresizingMask = [.flexibleWidth]
        
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


//extension UILabel {
//    func heightForLabel(text:String, font:UIFont, width:CGFloat) -> CGFloat {
//        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
//        label.numberOfLines = 0
//        label.lineBreakMode = NSLineBreakMode.byWordWrapping
//        label.font = font
//        label.text = text
//        
//        label.sizeToFit()
//        return label.frame.height
//    }
    
//}

