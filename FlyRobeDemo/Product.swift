//
//  Product.swift
//  FlyRobeDemo
//
//  Created by Anshuman Srivastava on 24/06/16.
//  Copyright © 2016 Anshuman Srivastava. All rights reserved.
//

import Foundation

class Product {
    var brandName: String?
    var productName: String?
    var imageURL: String?
    var mrp: Double?
    var rent: Double?
    
    static func parseProducts(obj: [String: AnyObject]) -> [Product] {
        var productsArray = [Product]()
        if let itemArray = obj["ItemArray"] as? [AnyObject] {
            for item in itemArray {
                let product = Product()
                if let brand = item["ItemBrandName"] as? String {
                    product.brandName = brand
                }
                if let name = item["ItemShortName"] as? String {
                    product.productName = name
                }
                if let gridFrontImageURL = item["GridFrontImageURL"] as? String {
                    product.imageURL = gridFrontImageURL
                }
                if let rent = item["ItemRental"] as? Double {
                    product.rent = rent
                }
                if let price = item["ItemRetail"] as? Double {
                    product.mrp = price
                }
                productsArray.append(product)
            }
        }
        return productsArray
    }
}
