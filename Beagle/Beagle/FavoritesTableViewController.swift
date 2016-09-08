//
//  FavoritesTableViewController.swift
//  Beagle
//
//  Created by Habib Miranda on 6/25/16.
//  Copyright © 2016 littleJohn's. All rights reserved.
//

import UIKit
import CoreData

class FavoritesTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        FavoriteController.sharedController.favoriteFetchedResultsController.delegate = self
    }
    
    var recommendation: Recommendation?


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 1
    }
    
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        

        return nil
        
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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

    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let detailVC = segue.destinationViewController as? DetailTableViewController
        if segue.identifier == "toDetailFromFavorites" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                recommendation = RecommendationContoller.sharedController.fetchedResultsController.objectAtIndexPath(indexPath) as? Recommendation else { return }
            detailVC?.recommendation = recommendation
        }
    }
}
