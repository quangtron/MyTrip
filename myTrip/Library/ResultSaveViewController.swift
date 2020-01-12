//
//  ResultLibraryViewController.swift
//  myTrip
//
//  Created by Le Thanh Thanh Toai on 12/20/18.
//  Copyright © 2018 Le Thanh Thanh Toai. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ResultSaveViewController: UIViewController {
    @IBOutlet weak var saveCollectionView: UICollectionView!
    @IBOutlet weak var savePageControl: UIPageControl!
    @IBOutlet weak var saveRatingStar: RatingStar!
    @IBOutlet weak var saveNamePlace: UITextField!
    @IBOutlet weak var saveDescriptionPlace: UITextView!
    @IBOutlet weak var countStarSave: UILabel!
    var index: Int?
    
    @IBAction func deleteAction(_ sender: UIButton) {
        let alert = UIAlertController(title: "Xoá", message: "Bạn muốn xoá địa điểm này không?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Có", style: .default) {(action) in
            let destination = self.storyboard?.instantiateViewController(withIdentifier: "saveNavigation") as? UINavigationController
            if saveLib[self.index!].downloadURL != "" {
                let ref = Database.database().reference().child("\((UserService.currentUserProfile?.uid)!)/\(saveLib[self.index!].placeKey!)/type")
                ref.removeValue()
                saveLib.remove(at: self.index!)
            } else {
                let ref = Database.database().reference().child("\((UserService.currentUserProfile?.uid)!)/\(saveLib[self.index!].placeKey!)")
                ref.removeValue()
                saveLib.remove(at: self.index!)
            }
            self.present(destination!, animated: true, completion: nil)
        }
        let noAction = UIAlertAction(title: "Không", style: .default, handler: nil)
        alert.addAction(yesAction)
        alert.addAction(noAction)
        present(alert,animated: true)
    }
    
    @IBAction func backAtion(_ sender: Any) {
        let destination = storyboard?.instantiateViewController(withIdentifier: "saveNavigation") as? UINavigationController
        
        let ref = Database.database().reference().child("\((UserService.currentUserProfile?.uid)!)/\((saveLib[self.index!].placeKey)!)/star")
        ref.setValue(saveRatingStar.starsRating)
        
        let newRef = Database.database().reference().child("places/\((saveLib[self.index!].placeKey)!)/star")
        newRef.setValue(saveRatingStar.starsRating)
        
        saveLib[self.index!].star = saveRatingStar.starsRating
        
        self.present(destination!, animated: true, completion: nil)
    }
    
    @IBAction func saveHotelButton(_ sender: UIButton) {
        let des = storyboard?.instantiateViewController(withIdentifier: "SaveHotelViewController") as? SaveHotelViewController
        des?.indexSH = index
        self.navigationController?.pushViewController(des!, animated: true)
    }
    
    @IBAction func saveHandbookButton(_ sender: UIButton) {
        let des = storyboard?.instantiateViewController(withIdentifier: "HandBookSaveViewController") as? HandBookSaveViewController
        des?.indexSHB = index
        self.navigationController?.pushViewController(des!, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if ((saveLib[index!].star ?? 0) > 0 ){
            countStarSave.text = "(\(countRating + 1) lượt đánh giá)"
        }
        saveRatingStar.starsRating = saveLib[index!].star ?? 0
        saveNamePlace?.text = saveLib[index!].name
        saveDescriptionPlace?.text = saveLib[index!].description
        savePageControl.numberOfPages = saveLib[index!].imgArray.count
    }
}

extension ResultSaveViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return saveLib[self.index!].imgArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ResultSaveCollectionViewCell", for: indexPath) as! ResultSaveCollectionViewCell
        let imageURL = URL(string: saveLib[self.index!].imgArray[indexPath.item])
        let data = try? Data(contentsOf: imageURL!)
        let image = UIImage(data: data!)
        cell.saveImageCollectionView.image = image
        
        return cell
    }
}

extension ResultSaveViewController: UICollectionViewDelegate, UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
    {
        let layout = self.saveCollectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        let roundedIndex = round(index)
        
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
        targetContentOffset.pointee = offset
        
        let x = targetContentOffset.pointee.x
        
        savePageControl.currentPage = Int(x / view.frame.width)
    }
}
