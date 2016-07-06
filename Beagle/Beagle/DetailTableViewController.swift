//
//  DetailTableViewController.swift
//  Beagle
//
//  Created by Habib Miranda on 6/25/16.
//  Copyright © 2016 littleJohn's. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var categoryArray = ["Food", "Books", "Travel", "Movies & Shows", "Entertainment", "Arts & Crafts", "Music", "Games & Apps", "Lifestyle & Health", "Other"]
    
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
        
        categoryTextfield.inputView = categoryPicker
        alertTextfield.inputView = datePicker
        
    }

    
    // MARK: - IBActions
    
    @IBAction func datePickerValueChanged(sender: UIDatePicker) {
        self.alertTextfield.text = sender.date.stringValue()
        self.alertValue = sender.date
    }
    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        updateRecommendation()
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func addToFavoritesButtonTapped(sender: AnyObject) {
    }
    
    // MARK: - Category Picker
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoryArray.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categoryArray[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        categoryTextfield.text = categoryArray[row]
    }
    
    // MARK: - Functionality
    
    func updateRecommendation() {
        guard let title = recommenderTexfield.text,
            let category = categoryTextfield.text else { return }
        let recommender = recommenderTexfield.text
        let details = detailTextfield.text
        let alert = alertValue
        
        if let recommendation = self.recommendation {
            RecommendationContoller.sharedController.updateRecommendation(recommendation, title: title, category: category, recommender: recommender, details: details, alert: alert)
        } else {
            RecommendationContoller.sharedController.addRecommendation(title, category: category, recommender: recommender, details: details, alert: alert)
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


















