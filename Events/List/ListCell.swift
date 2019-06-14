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
    let placeholderImage = UIImageView(image: #imageLiteral(resourceName: "placeholder_nomoon"))
    @IBOutlet weak var timestamp: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var location: UILabel!
        
    func configure(item: EventModel, index: Int, delegate: ListViewModelService?) {
        timestamp.text = item.date?.toLocalTime()
        title.text = item.title
        location.text = item.location1
                
        //set background image
        if let image = item.image {
            backgroundView = UIImageView(image: image)
        }else {
            backgroundView = placeholderImage
            delegate?.loadImage(index: index, completion: { [weak self] (image) in
                guard let image = image else { return }
                DispatchQueue.main.async {
                    self?.backgroundView = UIImageView(image: image)
                }
            })
        }
    }

}
