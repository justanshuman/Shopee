//
//  Constants.swift
//  FlyRobeDemo
//
//  Created by Anshuman Srivastava on 22/06/16.
//  Copyright © 2016 Anshuman Srivastava. All rights reserved.
//

import UIKit

class Constants: NSObject{
    static var screenSize = UIScreen.mainScreen().bounds.size
    static var cellSize = screenSize.width / 2 + 50
    static var productsCellSize = screenSize.width / 2 - 10
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
        //cellSize = screenSize.width / 2 + 50
    }
    
    static func getProductCellSize() -> CGSize {
        let w = CGFloat(160)
        let height = CGFloat(300)
        let screenWidth = UIScreen.mainScreen().bounds.size.width
        if screenWidth / 6 > 175 {
            return CGSize(width: screenWidth / 5, height: height)
        }
        if screenWidth / 5 > 175 {
            return CGSize(width: screenWidth / 5, height: height)
        }
        else if screenWidth / 4 > 175 {
            return CGSize(width: screenWidth / 4, height: height)
        }
        else if screenWidth / 3 > 175{
            return CGSize(width: screenWidth / 3, height: height)
        }
        else {
            return CGSize(width: screenWidth / 2, height: height)
        }
    
    }
}


