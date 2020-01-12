//
//  DetailSearchViewController.swift
//  myTrip
//
//  Created by Le Thanh Thanh Toai on 12/13/18.
//  Copyright © 2018 Le Thanh Thanh Toai. All rights reserved.
//

import UIKit
import FirebaseDatabase
import SwiftyJSON

class DetailSearchViewController: UIViewController {
    @IBOutlet weak var searchDescriptionPlace: UITextView!
    @IBOutlet weak var searchNamePlace: UITextField!
    @IBOutlet weak var searchCollection: UICollectionView!
    @IBOutlet weak var searchPageControl: UIPageControl!
    @IBOutlet weak var searchRatingStar: RatingStar!
    @IBOutlet weak var countStar: UILabel!
    var index: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if ((places[index!].star ?? 0) > 0 ){
            countStar.text = "(\(countRating + 1) lượt đánh giá)"
        }
        searchRatingStar.starsRating = places[index!].star ?? 0
        searchNamePlace?.text = places[index!].name
        searchDescriptionPlace?.text = places[index!].description
        searchPageControl.numberOfPages = places[index!].imgArray.count
    }
    
    @IBAction func saveAction(_ sender: UIButton) {
        let alert = UIAlertController(title: "Lưu", message: "Bạn muốn lưu địa điểm này?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Có", style: .default) {(action) in
            let newRef = Database.database().reference().child("\((UserService.currentUserProfile?.uid)!)/\((places[self.index!].placeKey)!)")
            let postDictionary = [
                "type": "save",
                "star": self.searchRatingStar.starsRating,
                "share": places[self.index!].typeShare ?? "" ,
                "URL": places[self.index!].downloadURL ?? "",
                "description" : places[self.index!].description ?? "",
                "name" : places[self.index!].name ?? "",
                "handbook": [
                    "name": places[self.index!].nameHandbook ?? "",
                    "description": places[self.index!].descriptionHandbook ?? "",
                    "image": places[self.index!].imageHandbook ?? "",
                ]
                ] as [String : Any]
            newRef.setValue(postDictionary)
            
            for i in 0..<places[self.index!].imgArray.count {
                let ref = Database.database().reference().child("\((UserService.currentUserProfile?.uid)!)/\((places[self.index!].placeKey)!)/images/image\(i+1)")
                let dataImage = places[self.index!].imgArray[i]
                ref.setValue(dataImage)
            }
            
            for j in 0..<places[self.index!].nameHotel.count {
                let ref = Database.database().reference().child("\((UserService.currentUserProfile?.uid)!)/\((places[self.index!].placeKey)!)/hotels/hotel\(j+1)")
                let dataHotel = [
                    "name": places[self.index!].nameHotel[j],
                    "description": places[self.index!].descriptionHotel[j],
                    "location": places[self.index!].location[j],
                    "price": places[self.index!].priceHotel[j],
                    "image": places[self.index!].imageHotel[j]
                ]
                ref.setValue(dataHotel)
            }
        }
        let noAction = UIAlertAction(title: "Không", style: .default, handler: nil)
        alert.addAction(yesAction)
        alert.addAction(noAction)
        present(alert,animated: true)
    }
    
    @IBAction func actionDismissButton(_ sender: Any) {
        let des = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBarController") as? MainTabBarViewController
        
        let ref = Database.database().reference().child("\((UserService.currentUserProfile?.uid)!)/\((places[self.index!].placeKey)!)/star")
        ref.setValue(searchRatingStar.starsRating)
        
        let newRef = Database.database().reference().child("places/\((places[self.index!].placeKey)!)/star")
        newRef.setValue(searchRatingStar.starsRating)
        
        des?.selectedViewController = des?.viewControllers?[2]
        self.present(des!, animated: true, completion: nil)
    }
    
    @IBAction func searchCamNang(_ sender: UIButton) {
        let des = storyboard?.instantiateViewController(withIdentifier: "CamNangViewController") as? CamNangViewController
        des?.indexCN = index
        self.navigationController?.pushViewController(des!, animated: true)
    }
    
    @IBAction func searchHotel(_ sender: UIButton) {
        let des = storyboard?.instantiateViewController(withIdentifier: "HotelViewController") as? HotelViewController
        des?.indexHotel = index
        self.navigationController?.pushViewController(des!, animated: true)
    }
}

extension DetailSearchViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return places[self.index!].imgArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailSearchCollectionViewCell", for: indexPath) as! DetailSearchCollectionViewCell
        
        let imageURL = URL(string: places[self.index!].imgArray[indexPath.item])
        let data = try? Data(contentsOf: imageURL!)
        let image = UIImage(data: data!)
        cell.imageSearch.image = image
        
        return cell
    }
}

extension DetailSearchViewController: UICollectionViewDelegate, UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
    {
        let layout = self.searchCollection?.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        let roundedIndex = round(index)
        
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
        targetContentOffset.pointee = offset
        
        let x = targetContentOffset.pointee.x
        
        searchPageControl.currentPage = Int(x / view.frame.width)
    }
}

