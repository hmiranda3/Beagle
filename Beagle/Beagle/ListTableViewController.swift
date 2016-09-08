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
    
    @IBOutlet weak var emptyView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RecommendationContoller.sharedController.fetchedResultsController.delegate = self
    }
    
    var recommendation: Recommendation?
    
    func doneButtonTapped() {
        
    }
    

    override func viewWillAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if RecommendationContoller.sharedController.fetchedResultsController.fetchedObjects?.count != 0 {
            emptyView.alpha = 0
            
        }
        
        tableView.reloadData()
    }
    

    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        let sections = RecommendationContoller.sharedController.fetchedResultsController.sections
        
        if sections?.count != 0 {
            emptyView.alpha = 0
            return sections!.count
            } else {
            if sections?.count == 0 {
            }
            return 0
            
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let recommendations = RecommendationContoller.sharedController.fetchedResultsController.sectionIndexTitles
        
        //TODO: See if there is a more efficient way of doing this. 
        switch recommendations[section] {
        case "B":
            return "Books"
        case "F":
            return "Food"
        case "S":
            return "Shows & Movies"
        case "T":
            return "Travel"
        case "E":
            return "Entertainment"
        case "A":
            return "Arts & Crafts"
        case "M":
            return "Music"
        case "G":
            return "Games & Apps"
        case "L":
            return "Lifestyle & Health"
        case "O":
            return "Other"
        default:
            break
        }

        if recommendations[section].isEmpty {
            return "No Category"
        } else {
            return recommendations[section]
        }

    }
    
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        guard let header = view as? UITableViewHeaderFooterView else {
            return
        }
        header.textLabel?.font = UIFont(name: "Futura", size: 30)
        header.textLabel?.textColor = UIColor.lightGrayColor()
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
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
     
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
     }
    
    
    func favoriteButtonTapped(sender: ButtonTableViewCell) {

        
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            guard let recommendation = RecommendationContoller.sharedController.fetchedResultsController.objectAtIndexPath(indexPath) as? Recommendation else {return}
            RecommendationContoller.sharedController.removeRecommendation(recommendation)
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
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      let detailVC = segue.destinationViewController as? DetailTableViewController
        if segue.identifier == "toDetailFromCell" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                recommendation = RecommendationContoller.sharedController.fetchedResultsController.objectAtIndexPath(indexPath) as? Recommendation else { return }
            detailVC?.recommendation = recommendation
        }
    }
}





