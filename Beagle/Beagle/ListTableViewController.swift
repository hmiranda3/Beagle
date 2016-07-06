//
//  ListTableViewController.swift
//  Beagle
//
//  Created by Habib Miranda on 6/25/16.
//  Copyright © 2016 littleJohn's. All rights reserved.
//

import UIKit
import CoreData

class ListTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RecommendationContoller.sharedController.fetchedResultsController.delegate = self
//        doneImage.userInteractionEnabled = true
//        let tapGesture = UITapGestureRecognizer(target: self, action: <#T##Selector#>)
    }
    
    var recommendation: Recommendation?
    
    func doneButtonTapped() {
        
    }
    
    // MARK: - Category Picker Setup (Will be deleted)
    
    
//    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
//        let text = categoryArray[row]
//        let attributedString = NSAttributedString(string: text, attributes: [NSForegroundColorAttributeName: UIColor.whiteColor()])
//        return attributedString
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    
   
    @IBAction func newButtonTapped(sender: AnyObject) {

    }

    
    @IBAction func favoritesButtonTapped(sender: AnyObject) {
        
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
       let sections = RecommendationContoller.sharedController.fetchedResultsController.sections
        if sections?.count != 0 {
            return sections!.count
        } else {
            TableViewHelper.EmptyMessage("Welcome to Beagle!\nTap on the \"Add New\" button to enter a new recommendation!", viewController: self)
           return 0
        }
        
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let categoryInfo = RecommendationContoller.sharedController.fetchedResultsController.sections,
            name = String?(categoryInfo[section].name) else {
                return nil
        }
            return name
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    
     override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCellWithIdentifier("listCell", forIndexPath: indexPath)
        guard let recommendation = RecommendationContoller.sharedController.fetchedResultsController.objectAtIndexPath(indexPath) as? Recommendation else {
            return UITableViewCell()
        }
        cell.textLabel?.text = recommendation.title
        cell.detailTextLabel?.text = recommendation.recommender
        
        
        
    
     // Configure the cell...
     
     return cell
     }
     
    
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
////      let detailVC = segue.destinationViewController as! DetailTableViewController
//        if segue.identifier == "toDetailView" {
//            if let detailVC = segue.destinationViewController as? DetailTableViewController, category = selectedCategory {
//                detailVC.category = category
//            }
//        }
//    }
}
