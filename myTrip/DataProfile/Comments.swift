//
//  Comments.swift
//  myTrip
//
//  Created by Le Thanh Thanh Toai on 12/13/18.
//  Copyright © 2018 Le Thanh Thanh Toai. All rights reserved.
//

import Foundation
class Comments {
    var id : String
    var author : UserProfile
    var text : String
    var createDt : Date
    
    init(id : String, author : UserProfile, text : String, timestamp : Double) {
        self.id = id
        self.author = author
        self.text = text
        self.createDt = Date(timeIntervalSince1970: timestamp / 1000)
    }
}
