//
//  DetailHandBookViewController.swift
//  myTrip
//
//  Created by ha quang trong on 1/17/19.
//  Copyright © 2019 Le Thanh Thanh Toai. All rights reserved.
//

import UIKit

class DetailHandBookViewController: UIViewController {
    @IBOutlet weak var imageDHV: UIImageView!
    @IBOutlet weak var nameDHV: UILabel!
    @IBOutlet weak var descriptionDHV: UITextView!
    @IBOutlet weak var namePlaceDHV: UITextField!
    var indexDHV: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameDHV.text = places[indexDHV!].nameHandbook
        namePlaceDHV.text = places[indexDHV!].name
        descriptionDHV.text = places[indexDHV!].descriptionHandbook
        let imageURL = URL(string: places[self.indexDHV!].imageHandbook!)
        let data = try? Data(contentsOf: imageURL!)
        let image = UIImage(data: data!)
        DispatchQueue.main.async {
            self.imageDHV.image = image
        }
    }
}
