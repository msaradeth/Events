//
//  ListViewModel.swift
//  Events
//
//  Created by Mike Saradeth on 6/12/19.
//  Copyright © 2019 Mike Saradeth. All rights reserved.
//

import Foundation
import UIKit

protocol ListViewModelService: LoadImageService {
    func loadImage(index: Int, completion: @escaping (UIImage?) -> Void)
}

class ListViewModel: NSObject, ListViewModelService {
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
    
    func loadImage(index: Int, completion: @escaping (UIImage?) -> Void) {
        loadImage(imageUrl: items[index].imageUrl) { [weak self] (image) in
            guard let self = self else { return }
            self.items[index].image = image
            self.items[index].saveImage()
            completion(image)
        }
    }
    
    deinit {
        print("deinit:  ListViewModel")
    }
    
}
