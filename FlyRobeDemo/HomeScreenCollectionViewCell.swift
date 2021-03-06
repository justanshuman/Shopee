//
//  HomeScreenCollectionViewCell.swift
//  FlyRobeDemo
//
//  Created by Anshuman Srivastava on 23/06/16.
//  Copyright © 2016 Anshuman Srivastava. All rights reserved.
//

import UIKit

class HomeScreenCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var progreeView: ProgressView!
    var url: String?
    var imageData: NSData?
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

class HomeScreenTableViewCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    var categoryList = [Category]()
    weak var colloectionViewSelectedDelegate: ColloectionViewSelected?
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension HomeScreenTableViewCell: UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("HomeScreenCollectionViewCell", forIndexPath: indexPath) as! HomeScreenCollectionViewCell
        cell.progreeView.showProgressView()
        if let u = categoryList[indexPath.row].url , imageUrl = NSURL(string: u) {
            APIController.getImageDataFromUrl(imageUrl, success: { (imageData) in
                dispatch_async(dispatch_get_main_queue(), {
                    () -> Void in
                    cell.imageView.image = UIImage(data: imageData)
                    cell.imageData = imageData
                    cell.progreeView.hideProgressView()
                })
            })
        }
        return cell
    }
    
}

extension HomeScreenTableViewCell: UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    
        colloectionViewSelectedDelegate?.collectionViewCellSelectedatWithEndPoint(categoryList[indexPath.row])
        
    }
    
}

extension HomeScreenTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: Double(Constants.cellSize), height: Double(Constants.cellSize))
    }
    
}