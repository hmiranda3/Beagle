//
//  FavoritesTableViewController.swift
//  Beagle
//
//  Created by Habib Miranda on 6/25/16.
//  Copyright © 2016 littleJohn's. All rights reserved.
//

import UIKit
import CoreData

class FavoritesTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        guard let sections = RecommendationContoller.sharedController.fetchedResultsController.sections else {return 1}
        return sections.count
    }
    
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let recommendations = RecommendationContoller.sharedController.fetchedResultsController.sectionIndexTitles
        
        //TODO: See if there is a more efficient way of doing this
        
        if recommendations[section] == "B" {
            return "Books"
        }
        
        if recommendations[section] == "F" {
            return "Food"
        }
        
        if recommendations[section] == "S" {
            return "Shows & Movies"
        }
        
        if recommendations[section] == "T" {
            return "Travel"
        }
        
        if recommendations[section] == "E" {
            return "Entertainment"
        }
        
        if recommendations[section] == "A" {
            return "Arts & Crafts"
        }
        
        if recommendations[section] == "M" {
            return "Music"
        }
        
        if recommendations[section] == "G" {
            return "Games & Apps"
        }
        
        if recommendations[section] == "L" {
            return "Lifestyle & Health"
        }
        
        if recommendations[section] == "O" {
            return "Other"
        }
        
        
        
        
        return recommendations[section]
        
    }

    
    

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return RecommendationContoller.sharedController.getFavoriteRecommendations().count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("favoriteListCell", forIndexPath: indexPath)

        let recommendations = RecommendationContoller.sharedController.getFavoriteRecommendations()
        let recommendation = recommendations[indexPath.row]
        
        cell.textLabel?.text = recommendation.title
        cell.detailTextLabel?.text = recommendation.recommender
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

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let detailVC = segue.destinationViewController as? DetailTableViewController
        if segue.identifier == "toDetailFromFavorites" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                recommendation = RecommendationContoller.sharedController.fetchedResultsController.objectAtIndexPath(indexPath) as? Recommendation else { return }
            detailVC?.recommendation = recommendation
        }
    }
}
