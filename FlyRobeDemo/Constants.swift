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
}


