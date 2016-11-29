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
    
    @IBOutlet weak var backButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        FavoriteController.sharedController.favoriteFetchedResultsController.delegate = self
    }
    
    var recommendation: Recommendation?


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "unwindToHome", sender: self)
    }
   
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        

        return nil
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let favCount = RecommendationContoller.sharedController.getFavoriteRecommendations().count
        if favCount == 0 {
            let imageName = "emptyFavorites"
            let image = UIImage(named: imageName)
            let emptyImageView = UIImageView(image: image!)
            emptyImageView.frame = CGRect(x: 0, y: 0, width: 100, height: 200)
            tableView.backgroundView = emptyImageView
            tableView.separatorStyle = .none
        } else {
            tableView.separatorStyle = .singleLine
        }

        
        return favCount
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteListCell", for: indexPath)
        let recommendations = RecommendationContoller.sharedController.getFavoriteRecommendations()
        let recommendation = recommendations[(indexPath as NSIndexPath).row]
        
    
        cell.textLabel?.text = recommendation.title
        cell.detailTextLabel?.text = recommendation.recommender

        return cell
    }

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailVC = segue.destination as? DetailTableViewController
        if segue.identifier == "toDetailFromFavorites" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let recommendation = RecommendationContoller.sharedController.fetchedResultsController.object(at: indexPath)
            detailVC?.recommendation = recommendation
        }
    }
}
