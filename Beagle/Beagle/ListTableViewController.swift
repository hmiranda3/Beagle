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
        self.navigationController?.navigationBar.backgroundColor = .blue
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "colorFixed"))
    }
    
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "unwindToHome", sender: self)
    }
    
    var recommendation: Recommendation?
    

    override func viewDidAppear(_ animated: Bool) {
    }

    // MARK: - Table view data source
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let sections = RecommendationContoller.sharedController.fetchedResultsController.sections else {
            
            return 0
        }
        if sections.count == 0 {
            let imageName = "emptyImage"
            let image = UIImage(named: imageName)
            let emptyImageView = UIImageView(image: image!)
            emptyImageView.frame = CGRect(x: 0, y: 0, width: 100, height: 200)
            tableView.backgroundView = emptyImageView
            tableView.separatorStyle = .none
        } else {
            tableView.separatorStyle = .singleLine
//            return sections.count
        }
        
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
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
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        guard let header = view as? UITableViewHeaderFooterView else {
            return
        }
        header.textLabel?.font = UIFont(name: "Futura", size: 30)
        header.textLabel?.textColor = UIColor.lightGray
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = RecommendationContoller.sharedController.fetchedResultsController.sections else { return 0 }
        tableView.backgroundView = nil
        let sectionInfo = sections[section]
        return sectionInfo.numberOfObjects
       
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as? ButtonTableViewCell else {
        return ButtonTableViewCell()
    }

    let recommendation = RecommendationContoller.sharedController.fetchedResultsController.object(at: indexPath)
    cell.updateWithRecommendation(recommendation)
    cell.delegate = self
    cell.recommendationTextLabel.text = recommendation.title
    cell.recommenderTextLabel.text = recommendation.recommender
     
    return cell
    }
     
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
     }
    
    
    func favoriteButtonTapped(_ sender: ButtonTableViewCell) {

        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let recommendation = RecommendationContoller.sharedController.fetchedResultsController.object(at: indexPath)
            RecommendationContoller.sharedController.removeRecommendation(recommendation)
        }
    }

    // MARK: - NSFetchedResultsControllerDelegate
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            guard let indexPath = indexPath else {return}
            tableView.deleteRows(at: [indexPath], with: .fade)
        case .insert:
            guard let newIndexPath = newIndexPath else {return}
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .move:
            guard let indexPath = indexPath,
                let newIndexPath = newIndexPath else {return}
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .update:
            guard let indexPath = indexPath else {return}
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .delete:
            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .automatic)
        case .insert:
            tableView.insertSections(IndexSet(integer: sectionIndex), with: .automatic)
        default:
            break
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      let detailVC = segue.destination as? DetailTableViewController
        if segue.identifier == "toDetailFromCell" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let recommendation = RecommendationContoller.sharedController.fetchedResultsController.object(at: indexPath)
            detailVC?.recommendation = recommendation
        }
    }
}





