//
//  DropDownView.swift
//  FlyRobeDemo
//
//  Created by Anshuman Srivastava on 23/06/16.
//  Copyright © 2016 Anshuman Srivastava. All rights reserved.
//

import UIKit

protocol CitySelected: NSObjectProtocol {
    func citySelected(city: Constants.City)
}

class DropDownView: UIView {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var delhiView: UIView!
    @IBOutlet weak var ahmedabadView: UIView!
    @IBOutlet weak var mumbaiView: UIView!
    weak var citySelectedDelegate: CitySelected?
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    func xibSetup() {
        if let view = loadViewFromNib() {
            contentView = view
            view.frame = bounds
            view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
            addSubview(view)
        }
        let tapGestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(ahmedabadSelected))
        tapGestureRecognizer1.numberOfTapsRequired = 1
        ahmedabadView.addGestureRecognizer(tapGestureRecognizer1)
        
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(hideCitySelectionView))
        tapGestureRecognizer2.numberOfTapsRequired = 1
        contentView.addGestureRecognizer(tapGestureRecognizer2)
        
        let tapGestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(delhiSelected))
        tapGestureRecognizer3.numberOfTapsRequired = 1
        delhiView.addGestureRecognizer(tapGestureRecognizer3)
        
        let tapGestureRecognizer4 = UITapGestureRecognizer(target: self, action: #selector(mumbaiSelected))
        tapGestureRecognizer4.numberOfTapsRequired = 1
        mumbaiView.addGestureRecognizer(tapGestureRecognizer4)
        
        
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "DropDownView", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil).first as? UIView
        return view
    }

    func showCitySelectionView(){
        contentView.hidden = false
        self.userInteractionEnabled = true
    }
    func hideCitySelectionView(){
        contentView.hidden = true
        self.userInteractionEnabled = false
    }
    func delhiSelected() {
        citySelected(Constants.City.DELHI)
    }
    func mumbaiSelected() {
        citySelected(Constants.City.MUMBAI)
    }
    func ahmedabadSelected() {
        citySelected(Constants.City.AHMEDABAD)
    }
    
    func citySelected(city: Constants.City){
        citySelectedDelegate?.citySelected(city)
        hideCitySelectionView()
    }
    
}
