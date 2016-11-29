//
//  DetailTableViewController.swift
//  Beagle
//
//  Created by Habib Miranda on 6/25/16.
//  Copyright © 2016 littleJohn's. All rights reserved.
//

import UIKit
import CloudKit
import SafariServices


class DetailTableViewController: UITableViewController, UIPickerViewDataSource, UITextFieldDelegate, UITextViewDelegate, UINavigationControllerDelegate {
    
    var categoryArray = ["Food", "Books", "Travel", "Shows & Movies", "Entertainment", "Arts & Crafts", "Music", "Games & Apps", "Lifestyle & Health", "Other"]
    
    var alertValue: Date?
    var recommendation: Recommendation?
    
    // MARK: - IBOutlets

    @IBOutlet weak var recommendationTextfield: UITextField!
    @IBOutlet weak var categoryTextfield: UITextField!
    @IBOutlet weak var recommenderTexfield: UITextField!
    @IBOutlet weak var detailTextfield: UITextView!
    @IBOutlet weak var alertTextfield: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    // MARK: - Textfield edits
    
    @IBAction func recommendationEdited(_ sender: AnyObject) {
        saveButton.isEnabled = true
    }
    
    @IBAction func categoryEdited(_ sender: AnyObject) {
        saveButton.isEnabled = true
    }
    
    @IBAction func recommenderEdited(_ sender: AnyObject) {
        saveButton.isEnabled = true
    }
    
    @IBAction func alertEdited(_ sender: AnyObject) {
    }
    
    func textViewDidChange(_ textView: UITextView) {
        saveButton.isEnabled = true
    }
    
    // MARK: - Picker Outlets
    
    @IBOutlet var categoryPicker: UIPickerView!
    @IBOutlet var datePicker: UIDatePicker!
    
    let imagePicker = UIImagePickerController()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailTextfield.delegate = self
        saveButton.isEnabled = false
        if let recommendation = recommendation {
            updateWithRecommendation(recommendation)
        }
        
        self.recommendationTextfield.delegate = self
        self.categoryTextfield.delegate = self
        self.recommenderTexfield.delegate = self
        self.alertTextfield.delegate = self
        self.detailTextfield.delegate = self
        
        
        
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        customView.backgroundColor = UIColor.lightGray
        
        let doneButton = UIButton(frame: CGRect(x: customView.frame.width - 55, y: 0, width: 50, height: 50))
        doneButton.setTitle("Done", for: UIControlState())
        doneButton.addTarget(self, action: #selector(dismissPicker), for: .touchUpInside)
        
        customView.addSubview(doneButton)
        
        categoryTextfield.inputAccessoryView = customView
        categoryTextfield.inputView = categoryPicker
        alertTextfield.inputView = datePicker
        alertTextfield.inputAccessoryView = customView
        detailTextfield.inputAccessoryView = customView
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(DetailTableViewController.tap(_:)))
        view.addGestureRecognizer(tapGesture)
                
    }
    
    // MARK: - Empty Required Text Field Handling
    
    func emptyTextfieldAlert() {
        
        if (recommendationTextfield.text!.isEmpty) {
            let alert = UIAlertController()
            alert.title = "Your recommendation needs a title!"
            alert.message = "Please fill out the \"Recommendation\" text field in order to create a new entry. Otherwise select cancel."
            let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
        
        if (categoryTextfield.text!.isEmpty) {
            let alert = UIAlertController()
            alert.title = "Please select a category!"
            alert.message = "In order to organize your entries, you'll need a category! If you are unsure of the category, select \"Other\"."
            let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
        
        if (recommendationTextfield.text!.isEmpty && categoryTextfield.text!.isEmpty) {
            let alert = UIAlertController()
            alert.title = "You havent created a Recommendation!"
            alert.message = "Enter a new recommendation and select a category. If you wish to cancel tap the \"Cancel\" button."
            let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }


    }
    
    // MARK: - Alert Notifications
    
    func presentAlert() {
        guard let recTitle = recommendationTextfield.text else { return }
        let notification = UILocalNotification()
        notification.fireDate = datePicker.date
        notification.alertBody = "Remember recommendation: \(recTitle)!"
        notification.alertAction = "open Beagle!"
        notification.soundName = UILocalNotificationDefaultSoundName
        UIApplication.shared.scheduleLocalNotification(notification)
    }
    
    // MARK: - To dismiss keyboards.
    
    func tap(_ gesture: UITapGestureRecognizer) {
        detailTextfield.resignFirstResponder()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    
    func dismissPicker() {
        categoryTextfield.resignFirstResponder()
        alertTextfield.resignFirstResponder()
        detailTextfield.resignFirstResponder()
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        self.view.endEditing(true)
        return
    }

    
    // MARK: - IBActions
    
    @IBAction func shareButtonTapped(_ sender: AnyObject) {
        shareRecommendation()
    }
    
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        saveButton.isEnabled = true
        self.alertTextfield.text = sender.date.stringValue()
        self.alertValue = sender.date
        if recommendation?.alert != nil {
            alertTextfield.text = recommendation?.alert?.stringValue()
        }
        
    }
    
    @IBAction func saveButtonTapped(_ sender: AnyObject) {
        emptyTextfieldAlert()
        if recommendation == nil && recommendationTextfield.text != "" && categoryTextfield.text != "" {
            presentAlert()
            emptyTextfieldAlert()
            createRecommendation()
            _ = navigationController?.popViewController(animated: true)
        } else if recommendationTextfield.text != "" && categoryTextfield.text != "" {
            presentAlert()
            emptyTextfieldAlert()
            updateRecommendation()
            _ = navigationController?.popViewController(animated: true)
        }
    }
    
    
    @IBAction func cancelButtonTapped(_ sender: AnyObject) {
       _ = navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: - Look-Up Button Links

    
    func searchFormat() -> String {
        guard let searchElement = recommendationTextfield.text?.replacingOccurrences(of: " ", with: "+", options: NSString.CompareOptions.literal, range: nil) else {
            return ""
        }
        return searchElement
    }
    
    @IBAction func googleTapped(_ sender: AnyObject) {
        guard let url = URL(string: "https://www.google.com/#q=\(searchFormat())") else { return }
        let svc = SFSafariViewController(url: url, entersReaderIfAvailable: true)
        self.present(svc, animated: true, completion: nil)
    }
    
    @IBAction func yelpTapped(_ sender: AnyObject) {
        let url = URL(string: "http://www.yelp.com/search?find_desc=\(searchFormat()))")!
        let svc = SFSafariViewController(url: url, entersReaderIfAvailable: true)
        self.present(svc, animated: true, completion: nil)
    }
    
    @IBAction func fundangoTapped(_ sender: AnyObject) {
        _ = searchFormat()
        let url = URL(string: "https://mobile.fandango.com/search?query=\(searchFormat())")!
        let svc = SFSafariViewController(url: url, entersReaderIfAvailable: true)
        self.present(svc, animated: true, completion: nil)
    }
   
    @IBAction func amazonTapped(_ sender: AnyObject) {
        let url = URL(string: "https://www.amazon.com/gp/aw/s/ref=is_s_ss_i_1_5?k=\(searchFormat())")!
        let svc = SFSafariViewController(url: url, entersReaderIfAvailable: true)
        self.present(svc, animated: true, completion: nil)
    }
    
    @IBAction func travelocityTapped(_ sender: AnyObject) {
        let url = URL(string: "https://www.travelocity.com/Hotel-Search?regionID=&hotelId=&age=Select+Child+Age#destination=\(searchFormat())")!
        let svc = SFSafariViewController(url: url, entersReaderIfAvailable: true)
        self.present(svc, animated: true, completion: nil)
    }
    
    // MARK: - Category Picker
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoryArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categoryArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        categoryTextfield.text = categoryArray[row]
    }
    
    // MARK: - Functionality
    
    func createRecommendation() {
        guard let title = recommendationTextfield.text,
            let category = categoryTextfield.text else { return }
        let recommender = recommenderTexfield.text
        let details = detailTextfield.text
        let alert = alertValue
        let isFavorite = false
        let isDone = false

        RecommendationContoller.sharedController.addRecommendation(title, category: category, recommender: recommender, details: details, alert: alert, isFavorite: isFavorite, isDone: isDone)
        

    }
    
    func updateRecommendation() {
        
        guard let title = recommendationTextfield.text,
            let category = categoryTextfield.text else { return }
        let recommender = recommenderTexfield.text
        let details = detailTextfield.text
        let alert = alertValue
        
        
        if let recommendation = self.recommendation {
            RecommendationContoller.sharedController.updateRecommendation(recommendation, title: title, category: category, recommender: recommender, details: details, alert: alert)
        }
    }
    
    func updateWithRecommendation(_ recommendation: Recommendation) {
        self.recommendation = recommendation
        
        title = recommendation.title
        recommendationTextfield.text = recommendation.title
        
        categoryTextfield.text = recommendation.category
        
        if let recommender = recommendation.recommender {
            recommenderTexfield.text = recommender
        }
        
        if let alert = recommendation.alert {
            alertTextfield.text = alert.stringValue()
        }
        
        if let details = recommendation.details {
            detailTextfield.text = details
        }
    }
    
    func shareRecommendation() {
       guard let titleText = recommendationTextfield?.text,
        let categoryText = categoryTextfield?.text else {
            emptyTextfieldAlert()
            return
        }
        
        let detailText = detailTextfield?.text
        let sharableMessage = ("Beagle!: \n\n\(titleText) \n\nCategory: \(categoryText) \n\n\(detailText ?? "")")
        
        let shareViewController = UIActivityViewController(activityItems: [sharableMessage], applicationActivities: nil)
        self.present(shareViewController, animated: true, completion: nil)
    }
    
    // MARK: - Section Header Format
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        guard let header = view as? UITableViewHeaderFooterView else {
            return
        }
        header.textLabel?.font = UIFont(name: "Futura", size: 20)
        header.textLabel?.textColor = UIColor.lightGray
        header.tintColor = UIColor.darkGray
    }

    
}




















