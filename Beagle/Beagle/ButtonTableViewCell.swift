//
//  ButtonTableViewCell.swift
//  Beagle
//
//  Created by Habib Miranda on 7/8/16.
//  Copyright © 2016 littleJohn's. All rights reserved.
//

import UIKit
@IBDesignable

class ButtonTableViewCell: UITableViewCell {

    @IBOutlet weak var recommendationTextLabel: UILabel!
    @IBOutlet weak var recommenderTextLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var recommendation: Recommendation?

    
    override func awakeFromNib() {
        super.awakeFromNib()
//        doneButtonTapped(self)
        // Initialization code
    }
    
    var delegate: ButtonTableViewCellDelegate?

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func favoriteButtonTapped(sender: AnyObject) {
        
        RecommendationContoller.sharedController.isFavoriteValueToggle(self.recommendation!)
        
        if self.recommendation!.isFavorite == true {
            favoriteButton.setImage(UIImage(named: "redheart"), forState: .Normal)
        } else {
            favoriteButton.setImage(UIImage(named: "emptyheart"), forState: .Normal)
        }
    }
    
    func updateButton(isFavorite: Bool) {
        
        if isFavorite == true {
            favoriteButton.setImage(UIImage(named: "redheart"), forState: .Normal)
        } else {
            favoriteButton.setImage(UIImage(named: "emptyheart"), forState: .Normal)
        }
        
    }
    
    func updateDoneButton(isDone: Bool) {
        if isDone == true {
            doneButton.setImage(UIImage(named: "done"), forState: .Normal)
        } else {
            doneButton.setImage(UIImage(named: "empty"), forState: .Normal)
        }
    }


    @IBAction func doneButtonTapped(sender: AnyObject) {
        
        RecommendationContoller.sharedController.isDoneValueToggle(self.recommendation!)
        
        if self.recommendation?.isDone == true {
            doneButton.setImage(UIImage(named: "done"), forState: .Normal)
        } else {
            doneButton.setImage(UIImage(named: "empty"), forState: .Normal)
        }
    }
}

protocol ButtonTableViewCellDelegate {
    
    func favoriteButtonTapped(sender: ButtonTableViewCell)
}

extension ButtonTableViewCell {
    
    func updateWithRecommendation(recommendation: Recommendation) {
        
        self.recommendation = recommendation
        recommendationTextLabel.text = recommendation.title
        recommenderTextLabel.text = recommendation.recommender
        updateButton(recommendation.isFavorite!.boolValue)
        updateDoneButton(recommendation.isDone!.boolValue)

    }
}

