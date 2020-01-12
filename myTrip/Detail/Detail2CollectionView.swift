//
//  Detail2CollectionView.swift
//  myTrip
//
//  Created by ha quang trong on 1/16/19.
//  Copyright © 2019 Le Thanh Thanh Toai. All rights reserved.
//

import UIKit

class Detail2CollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource {
    override func awakeFromNib() {
        self.delegate = self
        self.dataSource = self
        self.reloadData()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return beaches.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Detail2CollectionViewCell", for: indexPath)
            as! Detail2CollectionViewCell
        
        cell.nameDetail2CVC.text = beaches[indexPath.item].name
        let imageURL = URL(string: beaches[indexPath.item].imgArray[0])
        let data = try? Data(contentsOf: imageURL!)
        let image = UIImage(data: data!)
        cell.imageDetail2CVC.image = image
        
        return cell
    }
}
