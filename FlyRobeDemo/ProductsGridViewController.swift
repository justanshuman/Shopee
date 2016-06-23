//
//  ProductsGridViewController.swift
//  FlyRobeDemo
//
//  Created by Anshuman Srivastava on 23/06/16.
//  Copyright © 2016 Anshuman Srivastava. All rights reserved.
//

import UIKit

class ProductsGridViewController: UIViewController {
    @IBOutlet weak var titleLabel:UILabel!
    var category = Category()
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = category.title
        self.title = "Products"
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.Default
    }
}