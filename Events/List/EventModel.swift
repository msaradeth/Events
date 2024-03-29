//
//  Event.swift
//  Events
//
//  Created by Mike Saradeth on 6/12/19.
//  Copyright © 2019 Mike Saradeth. All rights reserved.
//

import Foundation
import UIKit

let subDirectory = "PhunApp"

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

//MARK: Save and load images
extension EventModel: FileURLWithPathService {
    func saveImage() {
        guard let image = image else { return }
        do {
            let fileURLWithPath = getFileURLWithPath(filename: String(id), subDirectory: subDirectory)
            let data = image.jpegData(compressionQuality: 1)
            try data?.write(to: fileURLWithPath, options: .atomic)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func loadImage() -> UIImage? {
        do {
            let fileURLWithPath = getFileURLWithPath(filename: String(id), subDirectory: subDirectory)
            let data = try Data(contentsOf: fileURLWithPath)
            let image = UIImage(data: data)
            return image
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
}


//MARK: Save Array of Model
extension Array: FileURLWithPathService where Element == EventModel {
    func save() throws {
        let fileURLWithPath = getFileURLWithPath(filename: "events", subDirectory: subDirectory)
        let encoder = JSONEncoder()
        let data = try encoder.encode(self)
        try data.write(to: fileURLWithPath, options: .atomic)
    }
    
    func load() throws -> [EventModel] {
        let fileURLWithPath = getFileURLWithPath(filename: "events", subDirectory: subDirectory)
        let data = try Data(contentsOf: fileURLWithPath)
        let decoder = JSONDecoder()
        let items = try decoder.decode(Array<EventModel>.self, from: data)
        return items
    }
}
