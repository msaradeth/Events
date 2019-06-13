//
//  ListViewModel.swift
//  Events
//
//  Created by Mike Saradeth on 6/12/19.
//  Copyright © 2019 Mike Saradeth. All rights reserved.
//

import Foundation
import UIKit

protocol LoadImageService {
    func loadImage(index: Int, completion: @escaping (UIImage?) -> Void)
}

class ListViewModel: NSObject {
    var items: [EventModel]
    var eventService: EventService
    var count: Int {
        return items.count
    }
    subscript(indexPath: IndexPath) -> EventModel {
        return items[indexPath.row]
    }
    
    init(items: [EventModel], eventService: EventService) {
        self.items = items
        self.eventService = eventService
    }
    
    func loadData(completion: @escaping () -> Void) {
        eventService.loadData { [weak self] (items) in
            self?.items = items
            completion()
        }
    }
    
}


//MARK: load image
extension ListViewModel: LoadImageService {
    func loadImage(index: Int, completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            guard let self = self,
                let imageUrl = self.items[index].imageUrl,
                let url = URL(string: imageUrl) else { return }
            do {
                let data = try Data(contentsOf: url)
                self.items[index].image = UIImage(data: data)
                completion(self.items[index].image )
            }catch let error {
                print(error.localizedDescription)
            }
        }
    }
}
