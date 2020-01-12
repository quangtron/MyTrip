//
//  SaveHotelViewController.swift
//  myTrip
//
//  Created by ha quang trong on 1/16/19.
//  Copyright © 2019 Le Thanh Thanh Toai. All rights reserved.
//

import UIKit

class SaveHotelViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var saveHotelTableview: UITableView!
    var indexSH: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return saveLib[self.indexSH!].nameHotel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SaveHotelTableViewCell") as? SaveHotelTableViewCell
        
        cell?.nameLblSaveHotel.text = saveLib[self.indexSH!].nameHotel[indexPath.row]
        cell?.priceLblSaveHotel.text = saveLib[self.indexSH!].priceHotel[indexPath.row]
        let imageURL = URL(string: saveLib[self.indexSH!].imageHotel[indexPath.row])
        let data = try? Data(contentsOf: imageURL!)
        let image = UIImage(data: data!)
        DispatchQueue.main.async {
            cell?.imageSaveHotel.image = image
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let des = storyboard?.instantiateViewController(withIdentifier: "DetailSaveHotelViewController") as? DetailSaveHotelViewController
        
        des?.indexDSH = indexPath.row
        des?.indexSaveLib = self.indexSH
        
        self.navigationController?.pushViewController(des!, animated: true)
    }
}
