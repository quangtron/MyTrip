//
//  Detail3CollectionView.swift
//  myTrip
//
//  Created by ha quang trong on 1/16/19.
//  Copyright © 2019 Le Thanh Thanh Toai. All rights reserved.
//

import UIKit

class Detail3CollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate {
    override func awakeFromNib() {
        self.delegate = self
        self.dataSource = self
        self.reloadData()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return places.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Detail3CollectionViewCell", for: indexPath)
            as! Detail3CollectionViewCell
        
        cell.nameDetail3CVC.text = places[indexPath.item].name
        //DispatchQueue.main.async {
            let imageURL = URL(string: places[indexPath.item].imgArray[0])
            let data = try? Data(contentsOf: imageURL!)
            let image = UIImage(data: data!)
            cell.imageDetail3CVC.image = image
        //}
        
        return cell
    }
}
