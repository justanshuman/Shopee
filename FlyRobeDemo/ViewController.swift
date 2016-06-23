//
//  ViewController.swift
//  FlyRobeDemo
//
//  Created by Anshuman Srivastava on 22/06/16.
//  Copyright © 2016 Anshuman Srivastava. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var citySelectorStarterView: UIView!
    @IBOutlet weak var selectedCityNameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeaderImageView: UIView!
    @IBOutlet weak var waysToRentButton: UIButton!
    @IBOutlet weak var progressView: ProgressView!
    @IBOutlet weak var dropDownView: DropDownView!
    
    private var sectionsList = [MainSection]()
    private var tableViewSectionsList = [MainSection]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundView = nil
        tableView.backgroundColor = UIColor.whiteColor()
        tableView.registerNib(UINib(nibName: "HomeTableViewHeaderViewCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "HomeTableViewHeaderViewCell")
        waysToRentButton.layer.cornerRadius = waysToRentButton.frame.height / 2
        waysToRentButton.layer.borderWidth = 2.0
        waysToRentButton.layer.borderColor = UIColor.whiteColor().CGColor
        setTapGestureRecognizers()
        fetchSections()
        progressView.showProgressView()
        dropDownView.citySelectedDelegate = self
        hideCitySelectionView()
    }
    
    func setTapGestureRecognizers() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showCitySelectionView))
        tapGestureRecognizer.numberOfTapsRequired = 1
        citySelectorStarterView.addGestureRecognizer(tapGestureRecognizer)
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setUpScreen()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func  setUpScreen() {
        if let bar =  self.navigationController?.navigationBar {
            bar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
            bar.shadowImage = UIImage()
        }
    }
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    func fetchSections(){
        let url = "http://assets.flyrobeapp.com/api/ios/"
        APIController.get(url, queryParameters: nil, success: {
            [weak self](response) -> Void in
            if let r = response {
                self?.sectionsList = MainSection.parseSectionsResponse(r)
                if let t = self?.sectionsList {
                    self?.tableViewSectionsList.appendContentsOf(t)
                }
                dispatch_async(dispatch_get_main_queue(), {
                    () -> Void in
                    self?.progressView.hideProgressView()
                    self?.tableView.reloadData()
                })
            }
            }, failure: {
                [weak self](response) -> Void in
                dispatch_async(dispatch_get_main_queue(), {
                    () -> Void in
                    self?.progressView.hideProgressView()
                })
        })
    }
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        Constants.refresh()
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return tableViewSectionsList.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return Constants.cellSize
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("HomeScreenTableViewCell", forIndexPath: indexPath) as! HomeScreenTableViewCell
        if let t = tableViewSectionsList[safe: indexPath.section]?.categoryArray {
            cell.categoryList = t
        }
        cell.collectionView.reloadData()
        return cell
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 65
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterViewWithIdentifier("HomeTableViewHeaderViewCell") as! HomeTableViewHeaderViewCell
        headerView.sectionNameLabel.text = tableViewSectionsList[section].sectionName
        headerView.sectionDescLabel.text = tableViewSectionsList[section].descriptionText
        headerView.contentView.backgroundColor = UIColor.whiteColor()
        return headerView
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView: UITableViewHeaderFooterView = UITableViewHeaderFooterView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 5))
        footerView.contentView.backgroundColor = UIColor.clearColor()
        return footerView
    }
}

extension ViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let headerHeight = CGFloat(250)
        if scrollView == tableView {
            let offset = scrollView.contentOffset.y
            if offset <= 0 {
                tableViewHeaderImageView.frame = CGRect(x: offset, y: offset, width: Constants.screenSize.width - 2 * offset, height: headerHeight - offset)
                self.view.layoutIfNeeded()
            } else if offset > headerHeight - 20 {
                tableViewHeaderImageView.frame = CGRect(x: 0, y: offset - headerHeight + 20, width: Constants.screenSize.width, height: headerHeight)
                self.view.layoutIfNeeded()
            }
        }
    }
    
}
// Mark: Handle City selection
extension ViewController: CitySelected {
    func showCitySelectionView(){
        dropDownView.showCitySelectionView()
    }
    func hideCitySelectionView(){
        dropDownView.hideCitySelectionView()
    }
    func citySelected(city: Constants.City){
        selectedCityNameLabel.text = city.rawValue
        if city == Constants.City.AHMEDABAD {
            if tableViewSectionsList[1].sectionName == Constants.Section.ETHNIC.rawValue {
                tableView.beginUpdates()
                tableViewSectionsList.removeAtIndex(1)
                tableView.deleteSections(NSIndexSet(index: 1), withRowAnimation: .Fade)
                tableView.endUpdates()
            }
        }
        else {
            if tableViewSectionsList[1].sectionName != Constants.Section.ETHNIC.rawValue {
                tableView.beginUpdates()
                tableViewSectionsList.insert(sectionsList[1], atIndex: 1)
                tableView.insertSections(NSIndexSet(index: 1), withRowAnimation: .Fade)
                tableView.endUpdates()
            }
        }
        hideCitySelectionView()
    }
}