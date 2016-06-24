//
//  CategoryCollectionViewCell.swift
//  FlyRobeDemo
//
//  Created by Anshuman Srivastava on 24/06/16.
//  Copyright © 2016 Anshuman Srivastava. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var mainContentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mrpLabel: UILabel!
    @IBOutlet weak var rentLabel: UILabel!
    @IBOutlet weak var progreeView: ProgressView!
    
    var imageData: NSData?
    override func awakeFromNib() {
        super.awakeFromNib()
        mainContentView.layer.borderColor = UIColor.lightGrayColor().CGColor
        mainContentView.layer.borderWidth = 1.0
    }
}
