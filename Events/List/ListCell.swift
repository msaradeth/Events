//
//  ListCell.swift
//  Events
//
//  Created by Mike Saradeth on 6/12/19.
//  Copyright © 2019 Mike Saradeth. All rights reserved.
//

import UIKit

class ListCell: UICollectionViewCell {
    static let cellIdentifier = "cell"
    @IBOutlet weak var timestamp: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var location: UILabel!
    
    func configure(item: EventModel, index: Int, delegate: LoadImageService?) {
        timestamp.text = item.date
        title.text = item.title
        location.text = item.location1
        
        //set background color with image if exist
        if let image = item.image {
            backgroundColor = UIColor(patternImage: image)
        }else {
            delegate?.loadImage(index: index, completion: { [weak self] (image) in
                guard let bgImage = image else { return }
                DispatchQueue.main.async {
                    self?.backgroundColor = UIColor(patternImage: bgImage)
                }
            })
        }
    }

}
