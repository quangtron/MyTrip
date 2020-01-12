//
//  TipsViewController.swift
//  myTrip
//
//  Created by Le Thanh Thanh Toai on 12/12/18.
//  Copyright © 2018 Le Thanh Thanh Toai. All rights reserved.
//

import UIKit

class TipsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var tips = [ tipsData(id: "1", nameAddr: "18 mẹo tiết kiệm tiền đi du lịch dễ dàng hơn lúc nào hết", detail: "dã bao nhiêu lần tips nameAddr: 18 mẹo tiết kiệm tiền đi du lịch dễ dàng hơn lúc nào hết ã bao nhiêu lần dã bao nhiêu lần tips nameAddr: 18 mẹo tiết kiệm tiền đi du lịch dễ dàng hơn lúc nào hết ã bao nhiêu lần "),
                 tipsData(id: "2", nameAddr: "Bí kíp giành được ghế tốt nhất trên máy bay", detail: "ã bao nhiêu lần tips nameAddr: 18 mẹo tiết kiệm tiền đi du lịch dễ dàng hơn lúc nào hết ã bao nhiêu lần dã bao nhiêu lần tips nameAddr: 18 mẹo tiết kiệm tiền đi du lịch dễ dàng hơn lúc nào hết ã bao nhiêu lần")
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
        return tips.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TipsTableViewCell") as! TipsTableViewCell
        cell.set(tips: tips[indexPath.row])
        return cell
    }

}
