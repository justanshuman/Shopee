//
//  MainSection.swift
//  FlyRobeDemo
//
//  Created by Anshuman Srivastava on 23/06/16.
//  Copyright © 2016 Anshuman Srivastava. All rights reserved.
//

import Foundation

class MainSection {
    var sectionName: String?
    var descriptionText: String?
    var categoryArray = [Category]()
    
    static func parseSectionsResponse(obj : Dictionary<String, AnyObject>) -> [MainSection] {
        var sectionsList = [MainSection]()
        
        if let westerns = obj["Express"] as? [AnyObject] {
            let section = MainSection()
            section.sectionName = Constants.Section.WESTERN.rawValue
            section.descriptionText = "3 days rental | no deposit"
            section.categoryArray = getCategories(westerns)
            sectionsList.append(section)
        }
        if let ethnics = obj["Reserve"] as? [AnyObject] {
            let section = MainSection()
            section.sectionName = Constants.Section.ETHNIC.rawValue
            section.descriptionText = "4, 6, 8 days rental | customize"
            section.categoryArray = getCategories(ethnics)
            sectionsList.append(section)
        }
        if let ethnic = obj["Offers"] as? [AnyObject] {
            let section = MainSection()
            section.sectionName = Constants.Section.OFFERS.rawValue
            section.descriptionText = "Our special offers"
            section.categoryArray = getCategories(ethnic)
            sectionsList.append(section)
        }
        return sectionsList
    }
    
    static func getCategories(section: [AnyObject]) -> [Category] {
        var categoriesArray = [Category]()
        for cat in section {
            let category = Category()
            if let categoryObj = cat as? [String: AnyObject]{
                if let name = categoryObj["Name"] as? String {
                    category.name = name
                }
                if let title = categoryObj["Title"] as? String {
                    category.title = title
                }
                if let url = categoryObj["URL"] as? String {
                    category.url = url
                }
                if let subtitle = categoryObj["Subtitle"] as? String {
                    category.subTitle = subtitle
                }
                if let apiEndPoint = categoryObj["ApiEndPoint"] as? String {
                    category.apiEndPoint = apiEndPoint
                }
                if let requestParams = categoryObj["RequestParams"] as? String{
//                    do {
//                        //let data = NSData(requestParams)
//                        let jsonObject: AnyObject = try NSJSONSerialization.JSONObjectWithData(requestParams as! NSData, options: .MutableContainers)
//                        if let j = jsonObject as? [String: AnyObject] {
//                            print("yeah")
//                        }
//                    }
//                    catch{
//                        
//                    }
                    category.requestParams = requestParams
                }
                if let isVisible = categoryObj["is_visible"] as? String {
                    if isVisible.caseInsensitiveCompare("False") == .OrderedSame {
                        category.isVisible = false
                    }
                    else{
                        category.isVisible = true
                    }
                }
            }
            categoriesArray.append(category)
        }
        return categoriesArray
    }
}