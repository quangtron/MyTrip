//
//  MapsViewController.swift
//  myTrip
//
//  Created by Le Thanh Thanh Toai on 12/16/18.
//  Copyright © 2018 Le Thanh Thanh Toai. All rights reserved.
//

import UIKit
import GoogleMaps

class MapsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let camera = GMSCameraPosition.camera(withLatitude: 10.762435, longitude: 106.681189, zoom: 18.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        self.view = mapView
        
        let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: 10.762435, longitude: 106.681189))
        marker.title = "Đại học Khoa học tự nhiên"
        marker.snippet = "Tp.Hồ Chí Minh, Việt Nam"
        marker.map = mapView
        // Do any additional setup after loading the view.
    }
    

}
