//
//  ListTableViewController.swift
//  Beagle
//
//  Created by Habib Miranda on 6/25/16.
//  Copyright © 2016 littleJohn's. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var categoryArray = ["Food", "Books", "Travel", "Movies & Shows", "Entertainment", "Arts & Crafts", "Music", "Games & Apps", "Lifestyle & Health", "Other"]
    
    var lookUpCells: [LookUp] = []
    var category: Categories?
    var selectedCategory: String? = "Food"
    var delegate: LookUpTableViewCellDelegate?
    
    // MARK: - Category Piker Outlet
    
    @IBOutlet var categoryPicker: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        categoryPicker.hidden = true
        
    }
    
    //MARK: - Category Picker Setup
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView!) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoryArray.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categoryArray[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let category = categoryArray[row]
        selectedCategory = category
    }
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let text = categoryArray[row]
        let attributedString = NSAttributedString(string: text, attributes: [NSForegroundColorAttributeName: UIColor.whiteColor()])
        return attributedString
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    
   
    @IBAction func newButtonTapped(sender: AnyObject) {

        
//        let pickerView = UIView()
//        pickerView.frame = CGRect(x: (UIScreen.mainScreen().bounds.width / 2) - 175, y: (UIScreen.mainScreen().bounds.height / 2) - 125, width: 350, height: 300)
//        pickerView.backgroundColor = UIColor.darkGrayColor()
//        pickerView.alpha = 1.0
//        pickerView.layer.cornerRadius = 18
//        
//        let categoryPicker = UIPickerView(frame: CGRectMake(0, 25, pickerView.frame.width, pickerView.frame.height - 50))
//        categoryPicker.dataSource = self
//        categoryPicker.delegate = self
//        pickerView.addSubview(categoryPicker)
//        
//        let selectCategory = UILabel(frame: CGRectMake(0, 0, pickerView.frame.width, 50))
//        selectCategory.text = "Select a Category"
//        selectCategory.textColor = UIColor.whiteColor()
//        selectCategory.textAlignment = .Center
//        
//        let toolBar = UIToolbar(frame: CGRectMake(0, 235, pickerView.frame.width, 50))
//        toolBar.barTintColor = UIColor.darkGrayColor()
//        toolBar.layer.cornerRadius = 20
//        
//        let cancelButton = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: nil)
//        cancelButton.tintColor = UIColor.whiteColor()
//        
//        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
//        
//        
//        let nextButton = UIBarButtonItem(title: "Next", style: .Plain, target: self, action: nil)
//        nextButton.tintColor = UIColor.whiteColor()
        
        
//        toolBar.setItems([cancelButton, flexSpace, nextButton], animated: true)
//        let dismissButton = UIButton(frame: CGRectMake(0, 250, pickerView.frame.width / 4, 50))
//        dismissButton.setTitle("Cancel", forState: .Normal)
//        
//    
//        let nextButton = UIButton(frame: CGRectMake((pickerView.frame.width / 2) + 87.5, 250, pickerView.frame.width / 4, 50))
//        nextButton.setTitle("Next", forState: .Normal)
//        
//        
//        
//        pickerView.addSubview(dismissButton)
//        pickerView.addSubview(nextButton)
//        pickerView.addSubview(selectCategory)
//        pickerView.addSubview(toolBar)
//        
//        self.navigationController?.view.addSubview(pickerView)
        
        
//        categoryPicker.hidden = false
//        let categoryAlertController = UIAlertController(title: "Select Category", message: nil, preferredStyle: .Alert)
//        categoryAlertController.addTextFieldWithConfigurationHandler { (textfield) in
//            let categoryWheel = self.categoryPicker
//            textfield.inputView = categoryWheel
//        }
//        let createAction = UIAlertAction(title: "Add", style: .Default) { (_) in
//            self.performSegueWithIdentifier("toDetailView", sender: self)
//            self.tableView.reloadData()
//        }
//        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
//        categoryAlertController.addAction(createAction)
//        categoryAlertController.addAction(cancelAction)
//        presentViewController(categoryAlertController, animated: true, completion: nil)
    }

    
    @IBAction func favoritesButtonTapped(sender: AnyObject) {
        
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
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
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//      let detailVC = segue.destinationViewController as! DetailTableViewController
        if segue.identifier == "toDetailView" {
            if let detailVC = segue.destinationViewController as? DetailTableViewController, category = selectedCategory {
                detailVC.category = category
            }
        }
    }
}
