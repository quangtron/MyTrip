//
//  TipsTableViewCell.swift
//  myTrip
//
//  Created by Le Thanh Thanh Toai on 12/12/18.
//  Copyright © 2018 Le Thanh Thanh Toai. All rights reserved.
//

import UIKit

class TipsTableViewCell: UITableViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var detailLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func set(tips : tipsData){
       self.nameLbl.text = tips.nameAddr
       self.detailLbl.text = tips.detail
    }
}
