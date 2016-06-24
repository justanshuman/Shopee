//
//  Constants.swift
//  FlyRobeDemo
//
//  Created by Anshuman Srivastava on 23/06/16.
//  Copyright © 2016 Anshuman Srivastava. All rights reserved.
//

import UIKit

class Constants: NSObject{
    static var screenSize = UIScreen.mainScreen().bounds.size
    static var cellSize = screenSize.width / 2 + 50
    static var productsCellSize = screenSize.width / 2 - 10
    static let RUPEE_SYMBOL = "₹"
    enum City: String {
        case DELHI = "Delhi"
        case MUMBAI = "Mumbai"
        case AHMEDABAD = "Ahmedabad"
    }
    enum Section: String {
        case WESTERN = "Western"
        case ETHNIC = "Ethnic"
        case OFFERS = "Offers"
    }
    static func refresh(){
        screenSize = UIScreen.mainScreen().bounds.size
    }
    static func getCategoryCellSize() -> CGSize {
        let screenWidth = UIScreen.mainScreen().bounds.size.width
        let height = CGFloat(320.0)
        if screenWidth / 6 > 210 {
            return CGSize(width: screenWidth / 6, height: height)
        }
        else if screenWidth / 5 > 200 {
            return CGSize(width: screenWidth / 5, height: height)
        }
        else if screenWidth / 4 > 190 {
            return CGSize(width: screenWidth / 4, height: height)
        }
        else if screenWidth / 3 > 170 {
            return CGSize(width: screenWidth / 3, height: height)
        }
        else if screenWidth / 2 > 170 {
            return CGSize(width: screenWidth / 2, height: height)
        }
        else {
            return CGSize(width: screenWidth, height: height)
        }
    }
}


