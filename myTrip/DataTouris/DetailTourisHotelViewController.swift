//
//  DetailTourisHotelViewController.swift
//  myTrip
//
//  Created by ha quang trong on 1/17/19.
//  Copyright © 2019 Le Thanh Thanh Toai. All rights reserved.
//

import UIKit

class DetailTourisHotelViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var indexDetailTHV: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places[self.indexDetailTHV!].nameHotel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTourisHotelTableViewCell") as? DetailTourisHotelTableViewCell
        
        cell?.nameHotelDTHT.text = places[self.indexDetailTHV!].nameHotel[indexPath.row]
        cell?.priceDTHT.text = places[self.indexDetailTHV!].priceHotel[indexPath.row]
        let imageURL = URL(string: places[self.indexDetailTHV!].imageHotel[indexPath.row])
        let data = try? Data(contentsOf: imageURL!)
        let image = UIImage(data: data!)
        DispatchQueue.main.async {
            cell?.imageDTHT.image = image
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let des = storyboard?.instantiateViewController(withIdentifier: "Detail2TourisHotelViewController") as? Detail2TourisHotelViewController
        
        des?.indexDetail = indexPath.row
        des?.indexPlace = self.indexDetailTHV!
        
        self.navigationController?.pushViewController(des!, animated: true)
    }
}
