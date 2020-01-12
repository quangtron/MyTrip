//
//  HandbookData.swift
//  myTrip
//
//  Created by Le Thanh Thanh Toai on 12/13/18.
//  Copyright © 2018 Le Thanh Thanh Toai. All rights reserved.
//

import Foundation
class handbookData {
    var id : String
    var nameAddr : String
    var detail : String
    
    init(id : String, nameAddr : String, detail : String ) {
        self.id = id
        self.nameAddr = nameAddr
        self.detail = detail
    }
}
