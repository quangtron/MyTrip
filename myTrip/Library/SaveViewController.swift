//
//  LibraryViewController.swift
//  myTrip
//
//  Created by Le Thanh Thanh Toai on 12/20/18.
//  Copyright © 2018 Le Thanh Thanh Toai. All rights reserved.
//

import UIKit
import Firebase

class SaveViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var saveTableView: UITableView!
    
    @IBAction func backAction(_ sender: Any) {
        let des = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBarController") as? MainTabBarViewController
        des?.selectedViewController = des?.viewControllers?[3]
        self.present(des!, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveLib = []
        
        for i in 0..<myLib.count {
            if myLib[i].type != nil {
                saveLib.insert(myLib[i], at: 0)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return saveLib.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SaveTableViewCell") as! SaveTableViewCell
        
        let queue = DispatchQueue(label: "ConcurrentQueue", qos: .default, attributes: .concurrent)
        queue.async {
            DispatchQueue.main.async {
                cell.nameSaveLbl.text = saveLib[indexPath.row].name
            }
            
        }
        queue.async {
            if saveLib[indexPath.row].imgArray.count > 0{
                let imageURL = URL(string: saveLib[indexPath.row].imgArray[0])
                let data = try? Data(contentsOf: imageURL!)
                let image = UIImage(data: data!)
                DispatchQueue.main.async {
                    cell.imageSave.image = image
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destination = self.storyboard?.instantiateViewController(withIdentifier: "ResultSaveViewController") as? ResultSaveViewController
        destination?.index = Int(indexPath.row)
        self.navigationController?.pushViewController(destination!, animated: true)
    }
}
