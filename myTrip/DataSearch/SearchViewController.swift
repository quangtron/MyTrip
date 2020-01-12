//
//  SearchViewController.swift
//  myTrip
//
//  Created by Le Thanh Thanh Toai on 12/13/18.
//  Copyright © 2018 Le Thanh Thanh Toai. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchbar: UISearchBar!
    var currentNamePlaces = [String]()
    var namePlaceArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0..<places.count {
            namePlaceArray.append(places[i].name!)
        }
        
        self.tableView.reloadData()
    }
    //UISearchBar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        currentNamePlaces = namePlaceArray.filter({ (name) -> Bool in
            guard let text = searchBar.text else {
                return false
            }
            
            return name.contains(text)
        })
        
        tableView.reloadData()
    }
    //UItableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentNamePlaces.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! SearchTableViewCell
        
        cell.nameLbl.text = currentNamePlaces[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destination = self.storyboard?.instantiateViewController(withIdentifier: "detail") as? DetailSearchViewController
        
        for i in 0..<places.count {
            if currentNamePlaces[indexPath.row] == places[i].name {
                destination?.index = i
            }
        }
        self.navigationController?.pushViewController(destination!, animated: true)
    }
}
