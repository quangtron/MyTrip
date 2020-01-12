//
//  Detail2TourisHotelViewController.swift
//  myTrip
//
//  Created by ha quang trong on 1/17/19.
//  Copyright © 2019 Le Thanh Thanh Toai. All rights reserved.
//

import UIKit

class Detail2TourisHotelViewController: UIViewController {
    @IBOutlet weak var imageD2THV: UIImageView!
    @IBOutlet weak var locationD2THV: UILabel!
    @IBOutlet weak var priceD2THV: UILabel!
    @IBOutlet weak var descriptionD2THV: UILabel!
    @IBOutlet weak var nameD2THV: UITextField!
    var indexPlace: Int?
    var indexDetail: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameD2THV.text = places[self.indexPlace!].nameHotel[self.indexDetail!]
        priceD2THV.text = places[self.indexPlace!].priceHotel[self.indexDetail!]
        locationD2THV.text = places[self.indexPlace!].location[self.indexDetail!]
        descriptionD2THV.text = places[self.indexPlace!].descriptionHotel[self.indexDetail!]
        let imageURL = URL(string: places[self.indexPlace!].imageHotel[self.indexDetail!])
        let data = try? Data(contentsOf: imageURL!)
        let image = UIImage(data: data!)
        DispatchQueue.main.async {
            self.imageD2THV.image = image
        }
    }
}
