//
//  ShareViewController.swift
//  myTrip
//
//  Created by Le Thanh Thanh Toai on 12/20/18.
//  Copyright © 2018 Le Thanh Thanh Toai. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase

class ShareViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var shareTableView: UITableView!
    
    @IBAction func backAction(_ sender: Any) {
        let des = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBarController") as? MainTabBarViewController
        des?.selectedViewController = des?.viewControllers?[3]
        self.present(des!, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePlaces = []
        
        for i in 0..<myLib.count {
            if (myLib[i].downloadURL != nil && myLib[i].typeShare != nil) {
                if (myLib[i].downloadURL != "" && myLib[i].typeShare != "") {
                    imagePlaces.insert(myLib[i], at: 0)
                }
            }
        }
    }
    //UITableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imagePlaces.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShareTableViewCell") as! ShareTableViewCell

        let queue = DispatchQueue(label: "ConcurrentQueue", qos: .default, attributes: .concurrent)
        queue.async {
            DispatchQueue.main.async {
                cell.nameListLbl.text = imagePlaces[indexPath.row].name
            }
        }
        
        queue.async {
            let imageStorageRef = Storage.storage().reference(forURL: imagePlaces[indexPath.row].downloadURL!)
            imageStorageRef.getData(maxSize: 2 * 1024 * 1024) { [weak cell] (data, error) in
                if let error = error {
                    print("****** \(error)")
                } else {
                    if let imageData = data {
                        let image = UIImage(data: imageData)
                        DispatchQueue.main.async {
                            cell!.imageList.image = image
                        }
                    }
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destination = self.storyboard?.instantiateViewController(withIdentifier: "ResultShareViewController") as? ResultShareViewController
        destination?.index = Int(indexPath.row)
        self.navigationController?.pushViewController(destination!, animated: true)
    }
}
