//
//  EventService.swift
//  Events
//
//  Created by Mike Saradeth on 6/12/19.
//  Copyright © 2019 Mike Saradeth. All rights reserved.
//

import Foundation


struct EventService {
    
    func loadData(completion: @escaping ([EventModel]) -> Void) {
        if Reachability.isConnectedToNetwork() {
            loadFromServer(completion: completion)
        }else {
            loadFromDisk(completion: completion)
        }
    }
    
    func loadFromDisk(completion: @escaping ([EventModel]) -> Void) {
        do {
            var items = try [EventModel]().load()
            items.enumerated().forEach({ (index, item) in
                //Load images from disk
                items[index].image = item.loadImage()
            })
            completion(items)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    
    func loadFromServer(completion: @escaping ([EventModel]) -> Void) {
        let urlString = "https://raw.githubusercontent.com/phunware-services/dev-interview-homework/master/feed.json"
        HttpHelp.request(urlString, method: .get, success: { (dataResponse) in
            guard let data = dataResponse.data else { return }
            do {
                let decoder = JSONDecoder()
                let items = try decoder.decode(Array<EventModel>.self, from: data)
                try items.save()    //save to storage
                completion(items)
            }catch let error {
                print(error.localizedDescription)
            }            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
}
