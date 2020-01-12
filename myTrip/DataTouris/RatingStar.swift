//
//  RatingStar.swift
//  myTrip
//
//  Created by ha quang trong on 1/11/19.
//  Copyright © 2019 Le Thanh Thanh Toai. All rights reserved.
//

import UIKit

class RatingStar: UIStackView {
    var starsRating = 0
    var starsEmpty = "star"
    var starsFilled = "starfill"
    
    override func draw(_ rect: CGRect) {
        let starButtons = self.subviews.filter{$0 is UIButton}
        var starTag = 1
        
        for button in starButtons {
            if let button = button as? UIButton{
                button.setImage(UIImage(named: starsEmpty), for: .normal)
                button.addTarget(self, action: #selector(self.pressed(sender:)), for: .touchUpInside)
                button.tag = starTag
                starTag = starTag + 1
            }
        }
        setStarsRating(rating:starsRating)
    }
    
    func setStarsRating(rating:Int){
        self.starsRating = rating
        let stackSubViews = self.subviews.filter{$0 is UIButton}
        for subView in stackSubViews {
            if let button = subView as? UIButton{
                if button.tag > starsRating {
                    button.setImage(UIImage(named: starsEmpty), for: .normal)
                }else{
                    button.setImage(UIImage(named: starsFilled), for: .normal)
                }
            }
        }
    }
    
    @objc func pressed(sender: UIButton) {
        setStarsRating(rating: sender.tag)
    }
}
