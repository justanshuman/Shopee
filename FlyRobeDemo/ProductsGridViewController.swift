//
//  ProductsGridViewController.swift
//  FlyRobeDemo
//
//  Created by Anshuman Srivastava on 23/06/16.
//  Copyright © 2016 Anshuman Srivastava. All rights reserved.
//

import UIKit

class ProductsGridViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var noProductsView: UIView!
    @IBOutlet weak var progressView: ProgressView!
    var category = Category()
    var productsArray = [Product]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = category.title
        fetchProducts()
        progressView.showProgressView()
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"), style: .Plain, target: self, action: #selector(back))
        leftBarButtonItem.tintColor = UIColor.whiteColor()
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.Default
    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        Constants.refresh()
        collectionView.reloadData()
    }
    func back(){
        self.navigationController?.popViewControllerAnimated(true)
    }
    func fetchProducts() {
        APIController.post("http://" + category.apiEndPoint!, queryParameters: nil, body: category.requestParams, success: {
            [weak self](response) -> Void in
            if let r = response {
                self?.productsArray = Product.parseProducts(r)
                dispatch_async(dispatch_get_main_queue(), {
                    () -> Void in
                    self?.progressView.hideProgressView()
                    if self?.productsArray.count == 0 {
                        self?.noProductsView.hidden = false
                    }
                    else {
                        self?.noProductsView.hidden = true
                        self?.collectionView.reloadData()
                    }
                })
            }
            }, failure: {
                [weak self](response) -> Void in
                dispatch_async(dispatch_get_main_queue(), {
                    () -> Void in
                        self?.progressView.hideProgressView()
                        self?.noProductsView.hidden = false
                    })
        })
    }
    func showPDPVC(product: Product, imageData: NSData, frame: CGRect){
        if let pDPViewController = self.storyboard?.instantiateViewControllerWithIdentifier("pDPViewController") as? PDPViewController {
            pDPViewController.imageData = imageData
            pDPViewController.product = product
            pDPViewController.backFrame = frame
            self.navigationController?.pushViewController(pDPViewController, animated: false)
        }
    }
}

extension ProductsGridViewController: UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productsArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CategoryCollectionViewCell", forIndexPath: indexPath) as! CategoryCollectionViewCell
        var name = ""
        if  let b = productsArray[safe: indexPath.row]?.brandName where !b.isEmpty {
            name = b
        }
        if let n = productsArray[safe: indexPath.row]?.productName where !n.isEmpty {
            name  = name + ": " + n
        }
        cell.nameLabel.text = name
        if let mrp = productsArray[safe: indexPath.row]?.mrp  {
            cell.mrpLabel.text = Constants.RUPEE_SYMBOL + String(mrp)
        }
        if let rent = productsArray[safe: indexPath.row]?.rent  {
            cell.rentLabel.text = Constants.RUPEE_SYMBOL + String(rent)
        }
        cell.progreeView.showProgressView()
        if let u = productsArray[safe: indexPath.row]?.imageURL , imageUrl = NSURL(string: u) {
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

extension ProductsGridViewController: UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if let cell = collectionView.cellForItemAtIndexPath(indexPath) as? CategoryCollectionViewCell{
            var popUpView = UIImageView()
            let newFrame = cell.imageView.convertRect(self.view.bounds, toView: nil)
            popUpView.image = UIImage(data: cell.imageData!)
            popUpView.contentMode = .ScaleAspectFit
            let frame = CGRect(x: newFrame.origin.x ,y: newFrame.origin.y, width: cell.imageView.frame.size.width, height: cell.imageView.frame.size.height)
            popUpView.frame = CGRectMake(frame.minX, frame.minY, frame.width, frame.height)
            self.view.addSubview(popUpView)
            
            UIView.animateWithDuration(0.5, animations: {
                popUpView.frame = CGRectMake(50 ,84, UIScreen.mainScreen().bounds.size.width - 100, 300)
                }, completion: { (complete) in
                    popUpView.removeFromSuperview()
                    self.showPDPVC(self.productsArray[safe: indexPath.row]!, imageData: cell.imageData!, frame: frame)
            })
        }
    }
    
}

extension ProductsGridViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return Constants.getCategoryCellSize()
    }
    
}