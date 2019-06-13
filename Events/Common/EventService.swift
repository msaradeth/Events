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
        HttpHelp.request(urlString, method: .get, success: { (dataResponse) in
            debugPrint(dataResponse)
            guard let data = dataResponse.data else { return }
            do {
                let decoder = JSONDecoder()
                let events = try decoder.decode(Array<EventModel>.self, from: data)
                completion(events)
//                print(events)
            }catch let error {
                print(error.localizedDescription)
            }
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
}
