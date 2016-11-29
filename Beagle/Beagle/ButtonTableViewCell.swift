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
    }
    
    var delegate: ButtonTableViewCellDelegate?

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func favoriteButtonTapped(_ sender: AnyObject) {
        
        RecommendationContoller.sharedController.isFavoriteValueToggle(self.recommendation!)
        
        if self.recommendation!.isFavorite == true {
            favoriteButton.setImage(UIImage(named: "redheart"), for: UIControlState())
        } else {
            favoriteButton.setImage(UIImage(named: "emptyheart"), for: UIControlState())
        }
    }
    
    func updateButton(_ isFavorite: Bool) {
        
        if isFavorite == true {
            favoriteButton.setImage(UIImage(named: "redheart"), for: UIControlState())
        } else {
            favoriteButton.setImage(UIImage(named: "emptyheart"), for: UIControlState())
        }
        
    }
    
    func updateDoneButton(_ isDone: Bool) {
        if isDone == true {
            doneButton.setImage(UIImage(named: "plainCheck"), for: UIControlState())
        } else {
            doneButton.setImage(UIImage(named: "empty"), for: UIControlState())
        }
    }


    @IBAction func doneButtonTapped(_ sender: AnyObject) {
        
        RecommendationContoller.sharedController.isDoneValueToggle(self.recommendation!)
        
        if self.recommendation?.isDone == true {
            doneButton.setImage(UIImage(named: "plainCheck"), for: UIControlState())
        } else {
            doneButton.setImage(UIImage(named: "empty"), for: UIControlState())
        }
    }
}

protocol ButtonTableViewCellDelegate {
    
    func favoriteButtonTapped(_ sender: ButtonTableViewCell)
}

extension ButtonTableViewCell {
    
    func updateWithRecommendation(_ recommendation: Recommendation) {
        
        self.recommendation = recommendation
        recommendationTextLabel.text = recommendation.title
        recommenderTextLabel.text = recommendation.recommender
        updateButton(recommendation.isFavorite!.boolValue)
        updateDoneButton(recommendation.isDone!.boolValue)

    }
}

