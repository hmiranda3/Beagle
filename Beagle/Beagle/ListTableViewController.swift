//
//  ListTableViewController.swift
//  Beagle
//
//  Created by Habib Miranda on 6/25/16.
//  Copyright © 2016 littleJohn's. All rights reserved.
//

import UIKit
import CoreData

class ListTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, ButtonTableViewCellDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RecommendationContoller.sharedController.fetchedResultsController.delegate = self
        
//        if let recommendation = recommendation {
//            updateWithRecommendation(recommendation)
//        }
//        doneImage.userInteractionEnabled = true
//        let tapGesture = UITapGestureRecognizer(target: self, action: <#T##Selector#>)
    }
    
    var recommendation: Recommendation?
    
    func doneButtonTapped() {
        
    }
    

    override func viewWillAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.reloadData()
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
    
//    func updateWithRecommendation(recommendation: Recommendation) {
//        title = recommendation.title
//    }
    
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
//            TableViewHelper.EmptyMessage("Welcome to Beagle!\nTap on the \"Add New\" button to enter a new recommendation!", viewController: self)
           return 0
        }
        
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sections = SectionController.sharedController.sectionsArray
        if let name = sections[section].group {
            return name
        } else {
            return ""
        }
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = RecommendationContoller.sharedController.fetchedResultsController.sections else {
        return 0
        }
        let sectionInfo = sections[section]
        return sectionInfo.numberOfObjects
    }
    
    
     override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
     guard let cell = tableView.dequeueReusableCellWithIdentifier("listCell", forIndexPath: indexPath) as? ButtonTableViewCell,
        let recommendation = RecommendationContoller.sharedController.fetchedResultsController.objectAtIndexPath(indexPath) as? Recommendation else {
            return ButtonTableViewCell()
        }
        
     cell.updateWithRecommendation(recommendation)
     cell.delegate = self
     cell.recommendationTextLabel.text = recommendation.title
     cell.recommenderTextLabel.text = recommendation.recommender
     
     return cell
     }
     
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    func favoriteButtonTapped(sender: ButtonTableViewCell) {
//        guard let indexPath = tableView.indexPathForCell(sender),
//            recommendation = RecommendationContoller.sharedController.fetchedResultsController.objectAtIndexPath(indexPath) as? Recommendation else {return}
        
    }
    
    
     // Override to support editing the table view.
     override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
     if editingStyle == .Delete {
//        RecommendationContoller.sharedController.removeRecommendation(recommendation!)
     tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
     } else if editingStyle == .Insert {
        
     }
     }
    
    // MARK: - NSFetchedResultsControllerDelegate
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .Delete:
            guard let indexPath = indexPath else {return}
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        case .Insert:
            guard let newIndexPath = newIndexPath else {return}
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Automatic)
        case .Move:
            guard let indexPath = indexPath,
                newIndexPath = newIndexPath else {return}
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Automatic)
        case .Update:
            guard let indexPath = indexPath else {return}
            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
    
    
    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        switch type {
        case .Delete:
            tableView.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Automatic)
        case .Insert:
            tableView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Automatic)
        default:
            break
        }
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }

    
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
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//      let detailVC = segue.destinationViewController as! DetailTableViewController
//        if segue.identifier == "toDetailView" {
//            if let detailVC = segue.destinationViewController as? DetailTableViewController, category = selectedCategory {
//                detailVC.category = category
//            }
//        }
//    }
}
