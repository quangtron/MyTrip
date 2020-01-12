//
//  CommentsTableViewCell.swift
//  myTrip
//
//  Created by Le Thanh Thanh Toai on 12/13/18.
//  Copyright © 2018 Le Thanh Thanh Toai. All rights reserved.
//

import UIKit

class CommentsTableViewCell: UITableViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var commentLbl: UILabel!
    @IBOutlet weak var subtitleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        imgView.layer.cornerRadius = imgView.bounds.height / 2
        imgView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func set(comments : Comments) {
        ImageService.getImage(withURL: comments.author.photoURL) { image in
            self.imgView.image = image
        }
        self.usernameLbl.text = comments.author.username
        self.commentLbl.text = comments.text
        self.subtitleLbl.text = comments.createDt.calenderTimeSinceNow()
    }
}
