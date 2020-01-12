//
//  HotelTableViewCell.swift
//  myTrip
//
//  Created by ha quang trong on 1/15/19.
//  Copyright © 2019 Le Thanh Thanh Toai. All rights reserved.
//

import UIKit

class HotelTableViewCell: UITableViewCell {
    @IBOutlet weak var imageHotel: UIImageView!
    @IBOutlet weak var nameLblHotel: UILabel!
    @IBOutlet weak var priceLblHotel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
