//
//  DetailTourisViewController.swift
//  myTrip
//
//  Created by Le Thanh Thanh Toai on 12/15/18.
//  Copyright © 2018 Le Thanh Thanh Toai. All rights reserved.
//

import UIKit
import Firebase

class DetailTourisViewController: UIViewController {
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var starStackView: RatingStar!
    @IBOutlet weak var desHome: UITextView!
    @IBOutlet weak var nameHome: UITextField!
    @IBOutlet weak var countStar: UILabel!
    var number: Int?
    /*@IBAction func actionDismissButton(_ sender: Any) {
        //self.dismiss(animated: false, completion: nil)
        let des = self.storyboard?.instantiateViewController(withIdentifier: "naviTouris") as? UINavigationController
        self.present(des!, animated: true, completion: nil)
    }*/
    @IBAction func handbookAction(_ sender: UIButton) {
        let des = storyboard?.instantiateViewController(withIdentifier: "DetailTourisHandBookViewController") as? DetailTourisHandBookViewController
        des?.indexDTHV = number
        self.navigationController?.pushViewController(des!, animated: true)
    }
    
    @IBAction func hotelAction(_ sender: UIButton) {
        let des = storyboard?.instantiateViewController(withIdentifier: "DetailTourisHotelViewController") as? DetailTourisHotelViewController
        des?.indexDetailTHV = number
        self.navigationController?.pushViewController(des!, animated: true)
    }
    
    
    /*@IBAction func saveAciton(_ sender: UIButton) {
        let alert = UIAlertController(title: "Save", message: "Do you want to save this place?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "YES", style: .default) {(action) in
            let newRef = Database.database().reference().child("myPlaces").childByAutoId()
            let postDictionary = [
                "description" : self.desPl ?? "",
                "name" : self.namePl ?? "",
                "images": [
                    "image1": self.imageArr[0]
                ]
                ] as [String : Any]
            newRef.setValue(postDictionary)
        }
        let noAction = UIAlertAction(title: "NO", style: .default, handler: nil)
        alert.addAction(yesAction)
        alert.addAction(noAction)
        present(alert,animated: true)
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if ((places[self.number!].star ?? 0) > 0 ){
            countStar.text = "(\(countRating + 1) lượt đánh giá)"
        }
        starStackView.starsRating = places[self.number!].star ?? 0
        nameHome.text = places[self.number!].name
        desHome.text = places[self.number!].description
        pageControl.numberOfPages = places[self.number!].imgArray.count
    }
}

extension DetailTourisViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return places[self.number!].imgArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailTourisCollectionViewCell", for: indexPath) as! DetailTourisCollectionViewCell
        
        let imageURL = URL(string: places[self.number!].imgArray[indexPath.item])
        let data = try? Data(contentsOf: imageURL!)
        let image = UIImage(data: data!)
        DispatchQueue.main.async {
            cell.imageView.image = image
        }
        
        return cell
    }
}

extension DetailTourisViewController: UICollectionViewDelegate, UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
    {
        let layout = self.collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        let roundedIndex = round(index)
        
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
        targetContentOffset.pointee = offset
        
        let x = targetContentOffset.pointee.x
        
        pageControl.currentPage = Int(x / view.frame.width)
    }
}
