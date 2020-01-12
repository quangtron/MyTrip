//
//  ProductsCollection.swift
//  myTrip
//
//  Created by Le Thanh Thanh Toai on 12/12/18.
//  Copyright © 2018 Le Thanh Thanh Toai. All rights reserved.
//

import UIKit

class ProductsCollection: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource {
    
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath)
        as! HomeCollectionViewCell
        
        cell.nameAddrLbl.text = places[indexPath.item].name
        //DispatchQueue.main.async {
            let imageURL = URL(string: places[indexPath.item].imgArray[0])
            let data = try? Data(contentsOf: imageURL!)
            let image = UIImage(data: data!)
            cell.imgView.image = image
        //}
        
        
        return cell
    }
}
