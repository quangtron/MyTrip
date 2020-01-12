//
//  CamNangViewController.swift
//  myTrip
//
//  Created by ha quang trong on 1/15/19.
//  Copyright © 2019 Le Thanh Thanh Toai. All rights reserved.
//

import UIKit

class CamNangViewController: UIViewController {
    @IBOutlet weak var imageCN: UIImageView!
    @IBOutlet weak var nameLblCN: UILabel!
    @IBOutlet weak var descriptionCN: UITextView!
    @IBOutlet weak var namePlaceCN: UITextField!
    var indexCN: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        namePlaceCN.text = places[indexCN!].name
        nameLblCN.text = places[indexCN!].nameHandbook
        descriptionCN.text = places[indexCN!].descriptionHandbook
        let imageURL = URL(string: places[indexCN!].imageHandbook!)
        let data = try? Data(contentsOf: imageURL!)
        let image = UIImage(data: data!)
        DispatchQueue.main.async {
            self.imageCN.image = image
        }
    }
}
