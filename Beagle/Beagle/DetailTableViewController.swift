//
//  DetailTableViewController.swift
//  Beagle
//
//  Created by Habib Miranda on 6/25/16.
//  Copyright © 2016 littleJohn's. All rights reserved.
//

import UIKit
import SafariServices


class DetailTableViewController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate, UITextViewDelegate {
    
    var alertValue: NSDate?
    var recommendation: Recommendation?
    
    // MARK: - IBOutlets

    @IBOutlet weak var recommendationTextfield: UITextField!
    @IBOutlet weak var categoryTextfield: UITextField!
    @IBOutlet weak var recommenderTexfield: UITextField!
    @IBOutlet weak var detailTextfield: UITextView!
    @IBOutlet weak var alertTextfield: UITextField!
    
    // MARK: - Picker Outlets
    
    @IBOutlet var categoryPicker: UIPickerView!
    @IBOutlet var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let recommendation = recommendation {
            updateWithRecommendation(recommendation)
        }
        
        self.recommendationTextfield.delegate = self
        self.categoryTextfield.delegate = self
        self.recommenderTexfield.delegate = self
        self.alertTextfield.delegate = self
        self.detailTextfield.delegate = self
        
        
        
        let customView = UIView(frame: CGRectMake(0, 0, self.view.frame.width, 50))
        customView.backgroundColor = UIColor.lightGrayColor()
        
        let doneButton = UIButton(frame: CGRect(x: customView.frame.width - 55, y: 0, width: 50, height: 50))
        doneButton.setTitle("Done", forState: .Normal)
        doneButton.addTarget(self, action: #selector(dismissPicker), forControlEvents: .TouchUpInside)
        
        customView.addSubview(doneButton)
        
        categoryTextfield.inputAccessoryView = customView
        categoryTextfield.inputView = categoryPicker
        alertTextfield.inputView = datePicker
        alertTextfield.inputAccessoryView = customView
        
    }
    
    
    func dismissPicker() {
        categoryTextfield.resignFirstResponder()
        alertTextfield.resignFirstResponder()
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        self.view.endEditing(true)
        return
    }

    
    // MARK: - IBActions
    
    @IBAction func datePickerValueChanged(sender: UIDatePicker) {
        self.alertTextfield.text = sender.date.stringValue()
        self.alertValue = sender.date
//        self.view.endEditing(true)
    }
    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        if recommendation == nil {
            createRecommendation()
            navigationController?.popViewControllerAnimated(true)
        } else {
            updateRecommendation()
            navigationController?.popViewControllerAnimated(true)
        }
    }
    
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func addToFavoritesButtonTapped(sender: AnyObject) {
    }
    
    // MARK: - Look-Up Button Links
    
    @IBAction func googleTapped(sender: AnyObject) {
        let url = NSURL(string: "https://google.com")!
        let svc = SFSafariViewController(URL: url, entersReaderIfAvailable: true)
        self.presentViewController(svc, animated: true, completion: nil)
    }
    
    @IBAction func yelpTapped(sender: AnyObject) {
        let url = NSURL(string: "http://m.yelp.com")!
        let svc = SFSafariViewController(URL: url, entersReaderIfAvailable: true)
        self.presentViewController(svc, animated: true, completion: nil)
    }
    
    @IBAction func fundangoTapped(sender: AnyObject) {
        let url = NSURL(string: "https://mobile.fandango.com")!
        let svc = SFSafariViewController(URL: url, entersReaderIfAvailable: true)
        self.presentViewController(svc, animated: true, completion: nil)
    }
   
    @IBAction func pinterestTapped(sender: AnyObject) {
        let url = NSURL(string: "https://www.pinterest.com")!
        let svc = SFSafariViewController(URL: url, entersReaderIfAvailable: true)
        self.presentViewController(svc, animated: true, completion: nil)
    }
    
    @IBAction func amazonTapped(sender: AnyObject) {
        let url = NSURL(string: "https://www.amazon.com/178-0768892-8234266")!
        let svc = SFSafariViewController(URL: url, entersReaderIfAvailable: true)
        self.presentViewController(svc, animated: true, completion: nil)
    }
    
    @IBAction func travelocityTapped(sender: AnyObject) {
        let url = NSURL(string: "https://www.travelocity.com/MobileHotel")!
        let svc = SFSafariViewController(URL: url, entersReaderIfAvailable: true)
        self.presentViewController(svc, animated: true, completion: nil)
    }
    // MARK: - Category Picker
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return SectionController.sharedController.sectionsArray.count
//        return categoryArray.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return SectionController.sharedController.sectionsArray[row].group
//        return categoryArray[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        categoryTextfield.text = SectionController.sharedController.sectionsArray[row].group
    }
    
    // MARK: - Functionality
    
    func createRecommendation() {
        guard let title = recommendationTextfield.text,
            let sectionText = categoryTextfield.text else { return }
        let recommender = recommenderTexfield.text
        let details = detailTextfield.text
        let alert = alertValue
        let isFavorite = false
        
        var currentSection: Section?
        for section in SectionController.sharedController.sectionsArray {
            if section.group == sectionText {
                currentSection = section
                break
            } else {
                currentSection = nil
            }
        }
        
        if let mySection = currentSection {
                RecommendationContoller.sharedController.addRecommendation(title, category: mySection, recommender: recommender, details: details, alert: alert, isFavorite: isFavorite)
        }

    }
    
    func updateRecommendation() {
        guard let title = recommendationTextfield.text,
            let sectionText = categoryTextfield.text else { return }
        let recommender = recommenderTexfield.text
        let details = detailTextfield.text
        let alert = alertValue
        let isFavorite = false
        
        var currentSection: Section?
        for section in SectionController.sharedController.sectionsArray {
            if section.group == sectionText {
                currentSection = section
            } else {
                currentSection = nil
            }
        }
        
        if let mySection = currentSection {
            
            if let recommendation = self.recommendation {
                RecommendationContoller.sharedController.updateRecommendation(recommendation, title: title, category: mySection, recommender: recommender, details: details, alert: alert, isFavorite: isFavorite)
            }
        }
    }
    
    func updateWithRecommendation(recommendation: Recommendation) {
        self.recommendation = recommendation
        
        title = recommendation.title
        recommenderTexfield.text = recommendation.title
        
        if let category = recommendation.section {
            categoryTextfield.text = (category.valueForKey("Section") as! String)
        }
        
    }
    
    // MARK: - Table view data source

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "embedLookup" {
//            if let lookupVC = segue.destinationViewController as? LookUpViewController, category = category {
//                lookupVC.category = category
//            }
//        }
//    }
    
    
    

}


















