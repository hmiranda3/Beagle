//
//  DetailTableViewController.swift
//  Beagle
//
//  Created by Habib Miranda on 6/25/16.
//  Copyright © 2016 littleJohn's. All rights reserved.
//

import UIKit
import SafariServices


class DetailTableViewController: UITableViewController, UIPickerViewDataSource, UIImagePickerControllerDelegate, UITextFieldDelegate, UITextViewDelegate, UINavigationControllerDelegate {
    
    var categoryArray = ["Food", "Books", "Travel", "Shows & Movies", "Entertainment", "Arts & Crafts", "Music", "Games & Apps", "Lifestyle & Health", "Other"]
    
    var alertValue: NSDate?
    var recommendation: Recommendation?
    
    // MARK: - IBOutlets

    @IBOutlet weak var recommendationTextfield: UITextField!
    @IBOutlet weak var categoryTextfield: UITextField!
    @IBOutlet weak var recommenderTexfield: UITextField!
    @IBOutlet weak var detailTextfield: UITextView!
    @IBOutlet weak var alertTextfield: UITextField!
    
    // MARK: - Picker Outlets
    
    @IBOutlet var categoryPicker: UIPickerView!
    @IBOutlet var datePicker: UIDatePicker!
    
    let imagePicker = UIImagePickerController()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let recommendation = recommendation {
            updateWithRecommendation(recommendation)
        }
        
        self.recommendationTextfield.delegate = self
        self.categoryTextfield.delegate = self
        self.recommenderTexfield.delegate = self
        self.alertTextfield.delegate = self
        self.detailTextfield.delegate = self
        self.imagePicker.delegate = self
        
        
        
        let customView = UIView(frame: CGRectMake(0, 0, self.view.frame.width, 50))
        customView.backgroundColor = UIColor.lightGrayColor()
        
        let doneButton = UIButton(frame: CGRect(x: customView.frame.width - 55, y: 0, width: 50, height: 50))
        doneButton.setTitle("Done", forState: .Normal)
        doneButton.addTarget(self, action: #selector(dismissPicker), forControlEvents: .TouchUpInside)
        
        customView.addSubview(doneButton)
        
        categoryTextfield.inputAccessoryView = customView
        categoryTextfield.inputView = categoryPicker
        alertTextfield.inputView = datePicker
        alertTextfield.inputAccessoryView = customView
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(DetailTableViewController.tap(_:)))
        view.addGestureRecognizer(tapGesture)
        
        
        //Detail image input
        
        let detailCustomView = UIView(frame: CGRectMake(0, 0, self.view.frame.width, 50))
        detailCustomView.backgroundColor = UIColor.lightGrayColor()
        
        let addImageButton = UIButton(frame: CGRect(x: detailCustomView.frame.width - 105, y: 0, width: 100, height: 50))
        addImageButton.setTitle("Add Image", forState: .Normal)
        addImageButton.addTarget(self, action: #selector(addImageAction), forControlEvents: .TouchUpInside)
        
        detailCustomView.addSubview(addImageButton)
        detailTextfield.inputAccessoryView = detailCustomView
        
        
        
        
    
    }
    
    func emptyTextfieldAlert() {
        
        if (recommendationTextfield.text!.isEmpty) {
            let alert = UIAlertController()
            alert.title = "Your recommendation needs a title!"
            alert.message = "Please fill out the \"Recommendation\" text field in order to create a new entry. Otherwise select cancel."
            let okAction = UIAlertAction(title: "Ok", style: .Cancel, handler: nil)
            alert.addAction(okAction)
            presentViewController(alert, animated: true, completion: nil)
        }
        
        
        
        if (categoryTextfield.text!.isEmpty) {
            let alert = UIAlertController()
            alert.title = "Please select a category!"
            alert.message = "In order to organize your entries, you'll need a category! If you are unsure of the category, select \"Other\"."
            let okAction = UIAlertAction(title: "Ok", style: .Cancel, handler: nil)
            alert.addAction(okAction)
            presentViewController(alert, animated: true, completion: nil)
        }


    }
    
    func tap(gesture: UITapGestureRecognizer) {
        detailTextfield.resignFirstResponder()
    }

    
    // To dismiss detail keyboard upon touch outside.
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    
    func dismissPicker() {
        categoryTextfield.resignFirstResponder()
        alertTextfield.resignFirstResponder()
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        self.view.endEditing(true)
        return
    }

    
    // MARK: - IBActions
    
    @IBAction func datePickerValueChanged(sender: UIDatePicker) {
        self.alertTextfield.text = sender.date.stringValue()
        self.alertValue = sender.date
        
    }
    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        emptyTextfieldAlert()
        if recommendation == nil && recommendationTextfield.text != "" && categoryTextfield.text != "" {
            emptyTextfieldAlert()
            createRecommendation()
            navigationController?.popViewControllerAnimated(true)
        } else if recommendationTextfield.text != "" && categoryTextfield.text != "" {
            emptyTextfieldAlert()
            updateRecommendation()
            navigationController?.popViewControllerAnimated(true)
        }
        
        let notification = UILocalNotification()
        notification.fireDate = datePicker.date
        notification.alertBody = "You have a Recommendation to look at!"
        notification.alertAction = "Check it Out!"
        notification.soundName = UILocalNotificationDefaultSoundName
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    
    // MARK: - Look-Up Button Links
    
    @IBAction func googleTapped(sender: AnyObject) {
        let url = NSURL(string: "https://google.com")!
        let svc = SFSafariViewController(URL: url, entersReaderIfAvailable: true)
        self.presentViewController(svc, animated: true, completion: nil)
    }
    
    @IBAction func yelpTapped(sender: AnyObject) {
        let url = NSURL(string: "http://m.yelp.com")!
        let svc = SFSafariViewController(URL: url, entersReaderIfAvailable: true)
        self.presentViewController(svc, animated: true, completion: nil)
    }
    
    @IBAction func fundangoTapped(sender: AnyObject) {
        let url = NSURL(string: "https://mobile.fandango.com")!
        let svc = SFSafariViewController(URL: url, entersReaderIfAvailable: true)
        self.presentViewController(svc, animated: true, completion: nil)
    }
   
    @IBAction func pinterestTapped(sender: AnyObject) {
        let url = NSURL(string: "https://www.pinterest.com")!
        let svc = SFSafariViewController(URL: url, entersReaderIfAvailable: true)
        self.presentViewController(svc, animated: true, completion: nil)
    }
    
    @IBAction func amazonTapped(sender: AnyObject) {
        let url = NSURL(string: "https://www.amazon.com/178-0768892-8234266")!
        let svc = SFSafariViewController(URL: url, entersReaderIfAvailable: true)
        self.presentViewController(svc, animated: true, completion: nil)
    }
    
    @IBAction func travelocityTapped(sender: AnyObject) {
        let url = NSURL(string: "https://www.travelocity.com/MobileHotel")!
        let svc = SFSafariViewController(URL: url, entersReaderIfAvailable: true)
        self.presentViewController(svc, animated: true, completion: nil)
    }
    // MARK: - Category Picker
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoryArray.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categoryArray[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        categoryTextfield.text = categoryArray[row]
    }
    
    // MARK: - Functionality
    
    func createRecommendation() {
        guard let title = recommendationTextfield.text,
            let category = categoryTextfield.text else { return }
        let recommender = recommenderTexfield.text
        let details = detailTextfield.attributedText
        let alert = alertValue
        let isFavorite = false
        let isDone = false

        RecommendationContoller.sharedController.addRecommendation(title, category: category, recommender: recommender, details: details, alert: alert, isFavorite: isFavorite, isDone: isDone)
        

    }
    
    func updateRecommendation() {
        guard let title = recommendationTextfield.text,
            let category = categoryTextfield.text else { return }
        let recommender = recommenderTexfield.text
        let details = detailTextfield.attributedText
        let alert = alertValue
        
        
        if let recommendation = self.recommendation {
            RecommendationContoller.sharedController.updateRecommendation(recommendation, title: title, category: category, recommender: recommender, details: details, alert: alert)
        }
    }
    
    func updateWithRecommendation(recommendation: Recommendation) {
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
        
//        if let details = recommendation.details {
//            
//            if let attrString = details as? NSAttributedString {
//                attrString.enumerateAttribute(NSAttachmentAttributeName, inRange: NSMakeRange(0, attrString.length), options: [], usingBlock: { (value, range, bool) in
////                    if ((value?.isKindOfClass(NSTextAttachment)) != nil) {
////                        if let attachment = value as? NSTextAttachment {
////                            if let image = attachment.image {
////                                let oldWidth = image.size.width
//                                
////                                let scaleFactor = oldWidth / (self.detailTextfield.frame.size.width - 10)
////                                let formattedImage = UIImage(CGImage: image.CGImage!, scale: scaleFactor, orientation: UIImageOrientation.Up)
//                                
//                                
////                            }
////                        }
////                    }
//                })
//            }
//            print("------------------------------------------------\(details)")
//            if let stringDictionary = details as? [NSObject : AnyObject] {
//                print("THIS IS THE DETAILS TEXT: ----->> \(stringDictionary["NSAttachment"])")
//            }
//            detailTextfield.attributedText = details as! NSAttributedString
//        }
    }
    
    //MARK: - Detail Text Field Functionality:
    
    func addImageToDetailText() {
//        let attributedString = NSMutableAttributedString(string: "before after")
//        let textAttachment = NSTextAttachment()
        
//        let customView = UIView(frame: CGRectMake(0, 0, self.view.frame.width, 50))
//        customView.backgroundColor = UIColor.lightGrayColor()
//        
//        let addImageButton = UIButton(frame: CGRect(x: customView.frame.width - 55, y: 0, width: 50, height: 50))
//        addImageButton.setTitle("Add Image", forState: .Normal)
//        addImageButton.addTarget(self, action: #selector(addImageAction), forControlEvents: .TouchUpInside)
//        
//        customView.addSubview(addImageButton)
//        detailTextfield.inputAccessoryView = customView
        
        
//        let scaleFactor = (detailTextfield.frame.size.width - 10)
//        textAttachment.image = UIImage(CGImage: textAttachment.image!.CGImage!, scale: scaleFactor, orientation: .Up)
//        let attrStringWithImage = NSAttributedString(attachment: textAttachment)
//        attributedString.replaceCharactersInRange(NSMakeRange(6, 1), withAttributedString: attrStringWithImage)
//        detailTextfield.attributedText = attributedString
//        self.view.addSubview(detailTextfield)
        
    }
    
    func addImageAction() {
//        let alert = UIAlertController(title: "Select Photo Location", message: nil, preferredStyle: .ActionSheet)
        
//        if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
//            alert.addAction(UIAlertAction(title: "Photo Library", style: .Default, handler: { (_) -> Void in
//                self.imagePicker.sourceType = .PhotoLibrary
//                self.presentViewController(self.imagePicker, animated: true, completion: nil)
//            }))
//        }
//        
//        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
//            alert.addAction(UIAlertAction(title: "Camera", style: .Default, handler: { (_) -> Void in
//                self.imagePicker.sourceType = .Camera
//                self.presentViewController(self.imagePicker, animated: true, completion: nil)
//            }))
//        }
//        
//        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
//        
//        presentViewController(alert, animated: true, completion: nil)
//        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        picker.dismissViewControllerAnimated(true, completion: nil)
//        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
//            let attributedString = NSMutableAttributedString(string: detailTextfield.text)
//            let textAttachment = NSTextAttachment()
//            let oldWidth = image.size.width;
//            
//            let scaleFactor = oldWidth / (detailTextfield.frame.size.width - 100);
//            textAttachment.image = UIImage(CGImage: image.CGImage!, scale: scaleFactor, orientation: UIImageOrientation.Up)
//            let attrStringWithImage = NSAttributedString(attachment: textAttachment)
//            attributedString.appendAttributedString(attrStringWithImage)
//            detailTextfield.attributedText = attributedString
//        }
    }
}




















