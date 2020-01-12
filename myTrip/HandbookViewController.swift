//
//  HandbookViewController.swift
//  myTrip
//
//  Created by Le Thanh Thanh Toai on 12/12/18.
//  Copyright © 2018 Le Thanh Thanh Toai. All rights reserved.
//

import UIKit

class HandbookViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var handbook = [ handbookData(id: "1", nameAddr: "HandbookTableViewCell HandbookTableViewCell ", detail: "HandbookTableViewCell HandbookTableViewCell HandbookTableViewCell HandbookTableViewCell HandbookTableViewCell"),
                     handbookData(id: "2", nameAddr: "HandbookTableViewCell HandbookTableViewCell HandbookTableViewCell ", detail: "HandbookTableViewCellHandbookTableViewCellHandbookTableViewCellHandbookTableViewCellHandbookTableViewCell")
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        tableView.reloadData()

        // Do any additional setup after loading the view.
    }
    @IBAction func actionDismissButton(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HandbookTableViewCell") as! HandbookTableViewCell
        
        //cell.set(handbook: handbook[indexPath.row])
        cell.nameLbl.text = places[indexPath.row].name
        cell.detailLbt.text = places[indexPath.row].nameHandbook
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let des = storyboard?.instantiateViewController(withIdentifier: "DetailHandBookViewController") as? DetailHandBookViewController
        des?.indexDHV = indexPath.row
        self.navigationController?.pushViewController(des!, animated: true)
    }
    
}
