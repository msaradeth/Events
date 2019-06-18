//
//  DetailViewModel.swift
//  Events
//
//  Created by Mike Saradeth on 6/13/19.
//  Copyright © 2019 Mike Saradeth. All rights reserved.
//

import Foundation
import MessageUI

class DetailViewModel: NSObject {
    var item: EventModel
    
    init(item: EventModel) {
        self.item = item
    }
}

