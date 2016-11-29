//
//  HomeViewController.swift
//  Beagle
//
//  Created by Habib Miranda on 11/20/16.
//  Copyright © 2016 littleJohn's. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var viewAllButton: UIButton!
    @IBOutlet weak var seeFavoritesButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        viewAllButton.layer.cornerRadius = 20
        viewAllButton.layer.shadowRadius = 3
        viewAllButton.layer.shadowOffset = CGSize.zero
        viewAllButton.layer.shadowOpacity = 1
        viewAllButton.layer.shadowColor = UIColor.black.cgColor
        
        seeFavoritesButton.layer.cornerRadius = 20
        seeFavoritesButton.layer.shadowRadius = 3
        seeFavoritesButton.layer.shadowOffset = CGSize.zero
        seeFavoritesButton.layer.shadowOpacity = 1
        seeFavoritesButton.layer.shadowColor = UIColor.black.cgColor
        
    }
//    We want to put this action on the view controller we want to unwind to.
    @IBAction func unwindToHome(segue: UIStoryboardSegue) {
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
