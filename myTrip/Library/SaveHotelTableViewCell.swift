//
//  SaveHotelTableViewCell.swift
//  myTrip
//
//  Created by ha quang trong on 1/16/19.
//  Copyright © 2019 Le Thanh Thanh Toai. All rights reserved.
//

import UIKit

class SaveHotelTableViewCell: UITableViewCell {
    @IBOutlet weak var imageSaveHotel: UIImageView!
    @IBOutlet weak var nameLblSaveHotel: UILabel!
    @IBOutlet weak var priceLblSaveHotel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
