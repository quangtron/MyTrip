//
//  DetailTourisHandBookViewController.swift
//  myTrip
//
//  Created by ha quang trong on 1/17/19.
//  Copyright © 2019 Le Thanh Thanh Toai. All rights reserved.
//

import UIKit

class DetailTourisHandBookViewController: UIViewController {
    @IBOutlet weak var imageDTHV: UIImageView!
    @IBOutlet weak var namePlaceDTHV: UITextField!
    @IBOutlet weak var nameDTHV: UILabel!
    @IBOutlet weak var descriptionDTHV: UITextView!
    var indexDTHV: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameDTHV.text = places[indexDTHV!].nameHandbook
        namePlaceDTHV.text = places[indexDTHV!].name
        descriptionDTHV.text = places[indexDTHV!].descriptionHandbook
        let imageURL = URL(string: places[self.indexDTHV!].imageHandbook!)
        let data = try? Data(contentsOf: imageURL!)
        let image = UIImage(data: data!)
        DispatchQueue.main.async {
            self.imageDTHV.image = image
        }
    }
}
