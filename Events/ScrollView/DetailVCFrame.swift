//
//  ShowEvent.swift
//  Events
//
//  Created by Mike Saradeth on 6/17/19.
//  Copyright © 2019 Mike Saradeth. All rights reserved.
//

import Foundation
import UIKit

class DetailVCFrame: UIViewController {
    let text = "Sure enough, Swift’s new video ends with her wearing a fries costume while her onetime nemesis pops up in the burger costume she famously wore to the Met Gala after-party. As the characters around them have a food fight, Swift and Perry slowly walk towards one another and embrace. The video ends with Swift singing “you need to calm down” one last time while Perry flashes her a smile.  \nSure enough, Swift’s new video ends with her wearing a fries costume while her onetime nemesis pops up in the burger costume she famously wore to the Met Gala after-party. As the characters around them have a food fight, Swift and Perry slowly walk towards one another and embrace. The video ends with Swift singing “you need to calm down” one last time while Perry flashes her a smile. \nSure enough, Swift’s new video ends with her wearing a fries costume while her onetime nemesis pops up in the burger costume she famously wore to the Met Gala after-party. As the characters around them have a food fight, Swift and Perry slowly walk towards one another and embrace. The video ends with Swift singing “you need to calm down” one last time while Perry flashes her a smile. \n Sure enough, Swift’s new video ends with her wearing a fries costume while her onetime nemesis pops up in the burger costume she famously wore to the Met Gala after-party. As the characters around them have a food fight, Swift and Perry slowly walk towards one another and embrace. The video ends with Swift singing “you need to calm down” one last time while Perry flashes her a smile. \nSure enough, Swift’s new video ends with her wearing a fries costume while her onetime nemesis pops up in the burger costume she famously wore to the Met Gala after-party. As the characters around them have a food fight, Swift and Perry slowly walk towards one another and embrace. The video ends with Swift singing “you need to calm down” one last time while Perry flashes her a smile. \nSure enough, Swift’s new video ends with her wearing a fries costume while her onetime nemesis pops up in the burger costume she famously wore to the Met Gala after-party. As the characters around them have a food fight, Swift and Perry slowly walk towards one another and embrace. The video ends with Swift singing “you need to calm down” one last time while Perry flashes her a smile."
    
    
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.bounces = true
        scrollView.backgroundColor = .white
        return scrollView
    }()
    let headerImage: UIImageView = {
        let headerImage = UIImageView(frame: .zero)
        headerImage.clipsToBounds = true
        headerImage.contentMode = UIView.ContentMode.scaleToFill
        return headerImage
    }()
    let dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.font = UIFont.systemFont(ofSize: 21, weight: .bold)
        return dateLabel
    }()
    let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.sizeToFit()
        descriptionLabel.numberOfLines = 0
        return descriptionLabel
    }()
    fileprivate let defaultHeight: CGFloat = 300
    var event: EventModel

    init(event: EventModel) {
        self.event = event
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
        headerImage.image = event.image
        dateLabel.text = event.date?.toLocalTime()
        descriptionLabel.text = event.description
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupViews()
        NotificationCenter.default.addObserver(self, selector: #selector(orientationDidChange), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    @objc func orientationDidChange() {
        setupViews()
    }

    func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(headerImage)
        scrollView.addSubview(dateLabel)
        scrollView.addSubview(descriptionLabel)
        
        scrollView.frame = view.frame
        headerImage.frame = CGRect(x: 0, y: 0, width: scrollView.frame.width, height: defaultHeight)
        dateLabel.frame = CGRect(x: 8, y: headerImage.frame.maxY, width: scrollView.frame.width, height: 40)
        
        let labelHeight = descriptionLabel.getHeight(width: scrollView.bounds.width-16)
        descriptionLabel.frame = CGRect(x: 8, y: dateLabel.frame.maxY, width: scrollView.frame.width-16, height: labelHeight)
        
        var contentHeight = headerImage.bounds.height + dateLabel.bounds.height + descriptionLabel.bounds.height
        contentHeight = contentHeight > view.bounds.height ? contentHeight : view.frame.height
        scrollView.contentSize = CGSize(width: scrollView.bounds.width , height: contentHeight)
        
//        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        headerImage.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        dateLabel.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        descriptionLabel.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        view.layoutIfNeeded()
    }
 

    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension DetailVCFrame: UIScrollViewDelegate {
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


extension UILabel {
    func getHeight(width:CGFloat) -> CGFloat {
        let label = self
        label.frame = CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude)
        label.sizeToFit()
        return label.frame.height
    }
    
}
