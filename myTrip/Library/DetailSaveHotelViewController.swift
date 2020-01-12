//
//  DetailSaveHotelViewController.swift
//  myTrip
//
//  Created by ha quang trong on 1/16/19.
//  Copyright © 2019 Le Thanh Thanh Toai. All rights reserved.
//

import UIKit

class DetailSaveHotelViewController: UIViewController {
    @IBOutlet weak var imageDetailSaveHotel: UIImageView!
    @IBOutlet weak var locationDetailSaveHotel: UILabel!
    @IBOutlet weak var priceDetailSaveHotel: UILabel!
    @IBOutlet weak var desDetailSaveHotel: UILabel!
    @IBOutlet weak var nameDetailSaveLib: UITextField!
    var indexDSH: Int?
    var indexSaveLib: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameDetailSaveLib.text = saveLib[self.indexSaveLib!].nameHotel[self.indexDSH!]
        priceDetailSaveHotel.text = saveLib[self.indexSaveLib!].priceHotel[self.indexDSH!]
        locationDetailSaveHotel.text = saveLib[self.indexSaveLib!].location[self.indexDSH!]
        desDetailSaveHotel.text = saveLib[self.indexSaveLib!].descriptionHotel[self.indexDSH!]
        let imageURL = URL(string: saveLib[self.indexSaveLib!].imageHotel[self.indexDSH!])
        let data = try? Data(contentsOf: imageURL!)
        let image = UIImage(data: data!)
        DispatchQueue.main.async {
            self.imageDetailSaveHotel.image = image
        }
    }
}
