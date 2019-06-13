//
//  ListViewModel.swift
//  Events
//
//  Created by Mike Saradeth on 6/12/19.
//  Copyright © 2019 Mike Saradeth. All rights reserved.
//

import Foundation
import RxSwift

class ListViewModel: NSObject {
    var subject: BehaviorSubject<[EventModel]>
    var eventService: EventService
    
    init(items: [EventModel], eventService: EventService) {
        self.eventService = eventService
        self.subject = BehaviorSubject<[EventModel]>(value: items)
    }
    
    func loadData() {
        eventService.loadData { [weak self] (items) in
            self?.subject.onNext(items)
        }
    }
    
}
