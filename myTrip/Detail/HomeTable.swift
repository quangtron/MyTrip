//
//  HomeTable.swift
//  myTrip
//
//  Created by Le Thanh Thanh Toai on 12/12/18.
//  Copyright © 2018 Le Thanh Thanh Toai. All rights reserved.
//

import UIKit

class HomeTable: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    var title = [   detailData(id: "0", nameTitle: ""),
                    detailData(id: "1", nameTitle: "Điểm đến phổ biến"),
                    detailData(id: "2", nameTitle: "Top bãi biển đẹp"),
                    detailData(id: "3", nameTitle: "Top vui chơi giải trí")
    ]
    
    override func awakeFromNib() {
        self.delegate = self
        self.dataSource = self
        self.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return title.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        
        if row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell") as! HomeTableViewCell
            return cell
        }
        if row == 1 {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTableViewCell") as! DetailTableViewCell
            cell.nameTitle.text = "Địa điểm phổ biến"
        return cell
        }
        if row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Detail2TableViewCell") as! Detail2TableViewCell
            cell.nameDetail2.text = "Top bãi biển đẹp"
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Detail3TableViewCell") as! Detail3TableViewCell
            cell.nameDetail3.text = "Top vui chơi giải trí"
            return cell
        }
    }
}
