//
//  ResultShareViewController.swift
//  myTrip
//
//  Created by Le Thanh Thanh Toai on 12/20/18.
//  Copyright © 2018 Le Thanh Thanh Toai. All rights reserved.
//

import UIKit
import Firebase

class ResultShareViewController: UIViewController{
    @IBOutlet weak var shareCollectionView: UICollectionView!
    @IBOutlet weak var sharePageControl: UIPageControl!
    @IBOutlet weak var shareRatingStar: RatingStar!
    @IBOutlet weak var namePlaceShare: UITextField!
    @IBOutlet weak var descriptionPlaceShare: UITextView!
    @IBOutlet weak var countStarShare: UILabel!
    var index: Int?
    
    @IBAction func backAction(_ sender: Any) {
        let des = storyboard?.instantiateViewController(withIdentifier: "naviShare") as? UINavigationController
        
        let ref = Database.database().reference().child("\((UserService.currentUserProfile?.uid)!)/\((imagePlaces[self.index!].placeKey)!)/star")
        ref.setValue(shareRatingStar.starsRating)
        
        let newRef = Database.database().reference().child("places/\((imagePlaces[self.index!].placeKey)!)/star")
        newRef.setValue(shareRatingStar.starsRating)
        
        imagePlaces[self.index!].star = shareRatingStar.starsRating
        
        self.present(des!, animated: true, completion: nil)
    }
    
    @IBAction func deleteAction(_ sender: UIButton) {
        let alert = UIAlertController(title: "Xoá", message: "Bạn muốn xoá địa điểm này không?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Có", style: .default) {(action) in
            let destination = self.storyboard?.instantiateViewController(withIdentifier: "naviShare") as? UINavigationController
            let ref = Database.database().reference().child("\((UserService.currentUserProfile?.uid)!)/\(imagePlaces[self.index!].placeKey!)")
            let oldRef = Database.database().reference().child("places/\((myLib[self.index!].placeKey)!)")
            oldRef.removeValue()
            ref.removeValue()
            imagePlaces.remove(at: self.index!)
            self.present(destination!, animated: true, completion: nil)
        }
        let noAction = UIAlertAction(title: "Không", style: .default, handler: nil)
        alert.addAction(yesAction)
        alert.addAction(noAction)
        present(alert,animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if ((imagePlaces[index!].star ?? 0) > 0 ){
            countStarShare.text = "(\(countRating + 1) lượt đánh giá)"
        }
        shareRatingStar.starsRating = imagePlaces[index!].star ?? 0
        namePlaceShare?.text = imagePlaces[index!].name
        descriptionPlaceShare?.text = imagePlaces[index!].description
        sharePageControl.numberOfPages = imagePlaces[index!].imgArray.count
    }
}

extension ResultShareViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagePlaces[self.index!].imgArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShareCollectionViewCell", for: indexPath) as! ShareCollectionViewCell
        let imageURL = URL(string: imagePlaces[self.index!].imgArray[indexPath.item])
        let data = try? Data(contentsOf: imageURL!)
        let image = UIImage(data: data!)
        cell.shareImageCollectionView.image = image
        
        return cell
    }
}

extension ResultShareViewController: UICollectionViewDelegate, UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
    {
        let layout = self.shareCollectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        let roundedIndex = round(index)
        
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
        targetContentOffset.pointee = offset
        
        let x = targetContentOffset.pointee.x
        
        sharePageControl.currentPage = Int(x / view.frame.width)
    }
}
