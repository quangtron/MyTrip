//
//  HandBookSaveViewController.swift
//  myTrip
//
//  Created by ha quang trong on 1/16/19.
//  Copyright © 2019 Le Thanh Thanh Toai. All rights reserved.
//

import UIKit

class HandBookSaveViewController: UIViewController {
    @IBOutlet weak var imageSHB: UIImageView!
    @IBOutlet weak var nameSHB: UILabel!
    @IBOutlet weak var desSHB: UITextView!
    @IBOutlet weak var namePlaceSHB: UITextField!
    var indexSHB: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        namePlaceSHB.text = saveLib[indexSHB!].name
        nameSHB.text = saveLib[indexSHB!].nameHandbook
        desSHB.text = saveLib[indexSHB!].descriptionHandbook
        let imageURL = URL(string: saveLib[indexSHB!].imageHandbook!)
        let data = try? Data(contentsOf: imageURL!)
        let image = UIImage(data: data!)
        DispatchQueue.main.async {
            self.imageSHB.image = image
        }
    }
}
