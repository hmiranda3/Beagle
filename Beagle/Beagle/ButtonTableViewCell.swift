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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var delegate: ButtonTableViewCellDelegate?

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func favoriteButtonTapped(sender: AnyObject) {
        
        if let delegate = delegate {
            delegate.favoriteButtonTapped(self)
        }

    }
    
    func updateButton(isFavorite: Bool) {
        
        if isFavorite {
            favoriteButton.setImage(UIImage(named: "fullblack"), forState: .Normal)
        } else {
            favoriteButton.setImage(UIImage(named: "emptyblack"), forState: .Normal)
        }
    }


    @IBAction func doneButtonTapped(sender: AnyObject) {
        if doneButton.imageView?.image == UIImage(named: "empty") {
            doneButton.setImage(UIImage(named: "done"), forState: .Normal)
        } else {
            if doneButton.imageView?.image == UIImage(named: "done") {
                doneButton.setImage(UIImage(named: "empty"), forState: .Normal)
            }
        }
    }
}

protocol ButtonTableViewCellDelegate {
    
    func favoriteButtonTapped(sender: ButtonTableViewCell)
}

extension ButtonTableViewCell {
    
    func updateWithRecommendation(recommendation: Recommendation) {
        
        recommendationTextLabel.text = recommendation.title
        recommenderTextLabel.text = recommendation.recommender
        updateButton(recommendation.isFavorite.boolValue)

    }
}

