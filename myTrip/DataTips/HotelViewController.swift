//
//  HotelViewController.swift
//  myTrip
//
//  Created by ha quang trong on 1/15/19.
//  Copyright © 2019 Le Thanh Thanh Toai. All rights reserved.
//

import UIKit

class HotelViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableViewHotel: UITableView!
    var indexHotel: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places[self.indexHotel!].nameHotel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HotelTableViewCell") as? HotelTableViewCell
        
        cell?.nameLblHotel.text = places[self.indexHotel!].nameHotel[indexPath.row]
        cell?.priceLblHotel.text = places[self.indexHotel!].priceHotel[indexPath.row]
        let imageURL = URL(string: places[self.indexHotel!].imageHotel[indexPath.row])
        let data = try? Data(contentsOf: imageURL!)
        let image = UIImage(data: data!)
        DispatchQueue.main.async {
            cell?.imageHotel.image = image
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let des = storyboard?.instantiateViewController(withIdentifier: "DetailHotelViewController") as? DetailHotelViewController
        
        des?.indexDetail = indexPath.row
        des?.indexPlace = self.indexHotel
        
        self.navigationController?.pushViewController(des!, animated: true)
    }
}
