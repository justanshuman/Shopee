//
//  PDPViewController.swift
//  FlyRobeDemo
//
//  Created by Anshuman Srivastava on 24/06/16.
//  Copyright © 2016 Anshuman Srivastava. All rights reserved.
//

import UIKit

class PDPViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var rentButton: UIButton!
    @IBOutlet weak var mrpLabel: UILabel!
    @IBOutlet weak var rentLabel: UILabel!
    var backFrame = CGRect()
    var product = Product()
    var imageData: NSData?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = product.brandName
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"), style: .Plain, target: self, action: #selector(back))
        leftBarButtonItem.tintColor = UIColor.whiteColor()
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        
        imageView.image = UIImage(data: imageData!)
        rentButton.layer.cornerRadius = 5.0
        nameLabel.text = product.productName
        if let mrp = product.mrp {
            mrpLabel.text = Constants.RUPEE_SYMBOL + "\(mrp)"
        }
        if let rent = product.rent {
            rentLabel.text = Constants.RUPEE_SYMBOL + "\(rent)"
        }
    }
    func back(){
        let popUpView = UIImageView()
        let newFrame = imageView.convertRect(self.view.bounds, toView: nil)
        popUpView.image = UIImage(data: imageData!)
        popUpView.contentMode = .ScaleAspectFit
        popUpView.frame = CGRectMake(newFrame.origin.x, newFrame.origin.y
            , imageView.frame.size.width, imageView.frame.size.height)
        self.view.addSubview(popUpView)
        imageView.hidden = true
        UIView.animateWithDuration(0.5, animations: {
            
            popUpView.frame = CGRectMake(self.backFrame.minX, self.backFrame.minY, self.backFrame.width, self.backFrame.height)
            }, completion: { (complete) in
                popUpView.removeFromSuperview()
                self.navigationController?.popViewControllerAnimated(false)
        })
    }
}
