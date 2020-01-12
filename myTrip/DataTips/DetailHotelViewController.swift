//
//  DetailHotelViewController.swift
//  myTrip
//
//  Created by ha quang trong on 1/15/19.
//  Copyright © 2019 Le Thanh Thanh Toai. All rights reserved.
//

import UIKit

class DetailHotelViewController: UIViewController {
    @IBOutlet weak var imageDetailHotel: UIImageView!
    @IBOutlet weak var locationDetailHotel: UILabel!
    @IBOutlet weak var priceDetailHotel: UILabel!
    @IBOutlet weak var desDetailHotel: UILabel!
    @IBOutlet weak var nameDetailHotel: UITextField!
    var indexDetail: Int?
    var indexPlace: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameDetailHotel.text = places[self.indexPlace!].nameHotel[self.indexDetail!]
        priceDetailHotel.text = places[self.indexPlace!].priceHotel[self.indexDetail!]
        locationDetailHotel.text = places[self.indexPlace!].location[self.indexDetail!]
        desDetailHotel.text = places[self.indexPlace!].descriptionHotel[self.indexDetail!]
        let imageURL = URL(string: places[self.indexPlace!].imageHotel[self.indexDetail!])
        let data = try? Data(contentsOf: imageURL!)
        let image = UIImage(data: data!)
        DispatchQueue.main.async {
            self.imageDetailHotel.image = image
        }
    }
}
