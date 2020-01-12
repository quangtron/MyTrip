//
//  UserProfile.swift
//  myTrip
//
//  Created by Le Thanh Thanh Toai on 12/13/18.
//  Copyright © 2018 Le Thanh Thanh Toai. All rights reserved.
//

import Foundation

class UserProfile {
    var uid : String
    var username : String
    var photoURL : URL
    
    init(uid : String, username : String, photoURL : URL) {
        self.uid = uid
        self.username = username
        self.photoURL = photoURL
    }
}
