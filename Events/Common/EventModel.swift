//
//  Event.swift
//  Events
//
//  Created by Mike Saradeth on 6/12/19.
//  Copyright © 2019 Mike Saradeth. All rights reserved.
//

import Foundation
import UIKit

struct EventModel: Codable {
    var id: Int
    var description: String
    var title: String
    var timestamp: String
    var imageUrl: String?
    var phone: String?
    var date: String?
    var location1: String
    var location2: String
    
    var image: UIImage?
    
    enum CodingKeys: String, CodingKey {
        case id
        case description
        case title
        case timestamp
        case imageUrl = "image"
        case phone
        case date
        case location1 = "locationline1"
        case location2 = "locationline2"
    }
}

extension Array where Element == EventModel {
    func save() throws {
        
    }
    
    func load() throws -> [EventModel] {
        var items = [EventModel]()
        
        return items
    }
}
