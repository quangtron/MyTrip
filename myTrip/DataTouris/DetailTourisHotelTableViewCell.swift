//
//  DetailTourisHotelTableViewCell.swift
//  myTrip
//
//  Created by ha quang trong on 1/17/19.
//  Copyright © 2019 Le Thanh Thanh Toai. All rights reserved.
//

import UIKit

class DetailTourisHotelTableViewCell: UITableViewCell {
    @IBOutlet weak var imageDTHT: UIImageView!
    @IBOutlet weak var nameHotelDTHT: UILabel!
    @IBOutlet weak var priceDTHT: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
