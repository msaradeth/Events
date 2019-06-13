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
        let fileURLWithPath = getFileURLWithPath()
        let encoder = JSONEncoder()
        let data = try encoder.encode(self)
        try data.write(to: fileURLWithPath)
    }
    
    func load() throws -> [EventModel] {
        let fileURLWithPath = getFileURLWithPath()
        let data = try Data(contentsOf: fileURLWithPath)
        let decoder = JSONDecoder()
        let items = try decoder.decode(Array<EventModel>.self, from: data)
        return items
    }
    
    func getFileURLWithPath() -> URL {
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURLWithPath = URL.init(fileURLWithPath: "events", relativeTo: directoryURL)
            .appendingPathExtension(".json")
        return fileURLWithPath
    }
}
