//
//  ShareTableViewCell.swift
//  myTrip
//
//  Created by Le Thanh Thanh Toai on 12/20/18.
//  Copyright © 2018 Le Thanh Thanh Toai. All rights reserved.
//

import UIKit

class ShareTableViewCell: UITableViewCell {
    @IBOutlet weak var imageList: UIImageView!
    @IBOutlet weak var nameListLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
