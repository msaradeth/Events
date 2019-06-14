//
//  Protocols.swift
//  Events
//
//  Created by Mike Saradeth on 6/13/19.
//  Copyright © 2019 Mike Saradeth. All rights reserved.
//

import Foundation
import UIKit

protocol LoadImageService {
    func loadImage(imageUrl: String?, completion: @escaping (UIImage?) -> Void)
}
extension LoadImageService {
    func loadImage(imageUrl: String?, completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global(qos: .userInteractive).async {
            do {
                guard let imageUrl = imageUrl else { return }
                let url = URL(string: imageUrl)
                let data = try Data(contentsOf: url!)
                let image = UIImage(data: data)
                completion(image)
            }catch let error {
                print(error.localizedDescription)
            }
        }
    }
}
