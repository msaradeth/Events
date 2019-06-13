//
//  EventService.swift
//  Events
//
//  Created by Mike Saradeth on 6/12/19.
//  Copyright © 2019 Mike Saradeth. All rights reserved.
//

import Foundation


struct EventService {
    let urlString = "https://raw.githubusercontent.com/phunware-services/dev-interview-homework/master/feed.json"
    
    func loadData(completion: @escaping ([EventModel]) -> Void) {
        guard Reachability.isConnectedToNetwork() else {
            //No internet connection, load from storage
            do {
                let items = try [EventModel]().load()
                print(items)
                completion(items)
            } catch let error {
                print(error.localizedDescription)
            }
            return
        }
        
        //Has internet connection, load from server
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
