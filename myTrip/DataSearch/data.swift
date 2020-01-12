//
//  data.swift
//  myTrip
//
//  Created by Le Thanh Thanh Toai on 12/13/18.
//  Copyright © 2018 Le Thanh Thanh Toai. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage
import SwiftyJSON

var places = [Place]()
var imagePlaces = [Place]()
var myLib = [Place]()
var saveLib = [Place]()
var beaches = [Place]()
var countRating = 0

class Place {
    private var imageUI: UIImage!
    var name: String?
    var description: String?
    var imgArray = [String]()
    var downloadURL: String?
    var placeKey: String?
    var type: String?
    var typeShare: String?
    var star: Int?
    var nameHotel = [String]()
    var priceHotel = [String]()
    var descriptionHotel = [String]()
    var imageHotel = [String]()
    var location = [String]()
    var nameHandbook: String?
    var descriptionHandbook: String?
    var imageHandbook: String?
    
    init(name: String, des: String, image: UIImage, typeShare: String) {
        self.name = name
        self.description = des
        self.imageUI = image
        self.typeShare = typeShare
    }
    
    init(snapshot: DataSnapshot) {
        places = []
        imgArray = []
        
        self.placeKey = snapshot.key
        let json = JSON(snapshot.value!)
        self.name = json["name"].stringValue
        self.description = json["description"].string
        self.downloadURL = json["URL"].string
        self.type = json["type"].string
        self.typeShare = json["share"].string
        self.star = json["star"].int
        let handbookJSON = JSON(json["handbook"])
        self.nameHandbook = handbookJSON["name"].string
        self.descriptionHandbook = handbookJSON["description"].string
        self.imageHandbook = handbookJSON["image"].string
        
        Database.database().reference().child("places/\(snapshot.key)/images").observe(.childAdded) { (snap) in
            let imgStr = snap.value as? String
            self.imgArray.insert(imgStr!, at: 0)
        }
        
        Database.database().reference().child("places/\(snapshot.key)/hotels").observe(.childAdded) { (snap) in
            let js = JSON(snap.value!)
            let nameH = js["name"].string
            self.nameHotel.insert(nameH!, at: 0)
            let descriptionH = js["description"].string
            self.descriptionHotel.insert(descriptionH!, at: 0)
            let priceH = js["price"].string
            self.priceHotel.insert(priceH!, at: 0)
            let imageH = js["image"].string
            self.imageHotel.insert(imageH!, at: 0)
            let locationH = js["location"].string
            self.location.insert(locationH!, at: 0)
        }
    }
    
    init(snapshot: DataSnapshot, key: String) {
        myLib = []
        imgArray = []
        
        self.placeKey = snapshot.key
        let json = JSON(snapshot.value!)
        self.name = json["name"].stringValue
        self.description = json["description"].string
        self.downloadURL = json["URL"].string
        self.type = json["type"].string
        self.typeShare = json["share"].string
        self.star = json["star"].int
        self.nameHandbook = "json"
        let handbookJSON = JSON(json["handbook"])
        self.nameHandbook = handbookJSON["name"].string
        self.descriptionHandbook = handbookJSON["description"].string
        self.imageHandbook = handbookJSON["image"].string
        
        Database.database().reference().child("\(key)/\(snapshot.key)/images").observe(.childAdded) { (snap) in
            let imgStr = snap.value as? String
            self.imgArray.insert(imgStr!, at: 0)
        }
        
        Database.database().reference().child("\(key)/\(snapshot.key)/hotels").observe(.childAdded) { (snap) in
            let js = JSON(snap.value!)
            let nameH = js["name"].string
            self.nameHotel.insert(nameH!, at: 0)
            let descriptionH = js["description"].string
            self.descriptionHotel.insert(descriptionH!, at: 0)
            let priceH = js["price"].string
            self.priceHotel.insert(priceH!, at: 0)
            let imageH = js["image"].string
            self.imageHotel.insert(imageH!, at: 0)
            let locationH = js["location"].string
            self.location.insert(locationH!, at: 0)
        }
    }
    
    func savePlace() {
        let newPlaceRef = Database.database().reference().child("places").childByAutoId()
        let newPlaceKey = newPlaceRef.key
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        if let imageData = imageUI.jpegData(compressionQuality: 0.5) {
            let storage = Storage.storage().reference().child("images/\(newPlaceKey!)")
            
            storage.putData(imageData, metadata: metaData) { (metaData, error) in
                if metaData != nil {
                    storage.downloadURL(completion: { (url, error) in
                        if url != nil {
                            self.downloadURL = url?.absoluteString
                            let postDictionary = [
                                "description" : self.description!,
                                "share": self.typeShare!,
                                "name" : self.name!,
                                "URL": self.downloadURL!,
                                "images": [
                                    "image1": self.downloadURL
                                ]
                                ] as [String : Any]
                            newPlaceRef.setValue(postDictionary)
                            let myRef = Database.database().reference().child("\((UserService.currentUserProfile?.uid)!)/\(newPlaceKey!)")
                            myRef.setValue(postDictionary)
                        }
                    })
                }
            }
        }
    }
}
