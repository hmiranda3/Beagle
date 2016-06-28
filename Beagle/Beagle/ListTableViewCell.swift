//
//  ListTableViewCell.swift
//  Beagle
//
//  Created by Habib Miranda on 6/28/16.
//  Copyright © 2016 littleJohn's. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var recommendationTextLabel: UILabel!
    
    @IBOutlet weak var recommenderTextLabel: UILabel!
    
    @IBOutlet weak var doneButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - IBActions
    
    @IBAction func doneButtonTapped(sender: AnyObject) {
    }

}
