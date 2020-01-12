//
//  TouristDestinationViewController.swift
//  myTrip
//
//  Created by Le Thanh Thanh Toai on 12/12/18.
//  Copyright © 2018 Le Thanh Thanh Toai. All rights reserved.
//

import UIKit
import Firebase

class TouristDestinationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    var number: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    /*@IBAction func actionDismissButton(_ sender: Any) {
        //self.dismiss(animated: false, completion: nil)
        let des = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBarController") as? MainTabBarViewController
        //des?.selectedViewController = des?.viewControllers?[0]
        self.present(des!, animated: true, completion: nil)
    }*/
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TourisTableViewCell") as! TourisTableViewCell
        
        cell.nameLbt.text = places[indexPath.row].name
        /*let imageURL = URL(string: places[indexPath.row].imgArray[0])
        let data = try? Data(contentsOf: imageURL!)
        let image = UIImage(data: data!)
        cell.imageView!.image = image*/
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destination = self.storyboard?.instantiateViewController(withIdentifier: "DetailTourisViewController") as? DetailTourisViewController
        destination?.number = indexPath.row
        self.navigationController?.pushViewController(destination!, animated: true)
    }
 
}
