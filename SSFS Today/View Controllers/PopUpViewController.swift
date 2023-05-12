//
//  PopUpViewController.swift
//  SSFS Today
//
//  Created by Brian Wilkinson on 9/14/17 on behalf of Sandy Spring Friends School
//  Copyright © 2017 SSFS. All rights reserved.
//
// Tutorial found at https://www.simplifiedios.net/swift-php-mysql-tutorial/
// Tutorial for moving view up found at: https://stackoverflow.com/questions/26070242/move-view-with-keyboard-using-swift
//

import UIKit

class PopUpViewController: UIViewController {
    //URL to our web service
    let URL_SAVE_RATING = "https://grover.ssfs.org/menus/ratings/api/createrating.php"
    
    var rating: Rating?
    
    @IBOutlet weak var entreeRatingStackView: RatingController!
    
    @IBOutlet weak var vegieRatingStackView: RatingController!
    
    @IBOutlet weak var commentField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Adds a way for the keyboard to be dismissed. User needs to tap outside.
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
        // Listens for when the keyboard comes up. Calls functions that move view up.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitRatingAndDismiss(_ sender: UIButton) {
        // TODO: Add an alert to confirm submission of rating.
        
        //created NSURL
        let requestURL = NSURL(string: URL_SAVE_RATING)
        
        //creating NSMutableURLRequest
        let request = NSMutableURLRequest(url: requestURL! as URL)
        
        //setting the method to post
        request.httpMethod = "POST"
        
        //getting values
        // Make sure the comment field is not blank
        var comment = ""
        if commentField.text != nil {
            comment = "&comment=" + commentField.text!
        } else {
            comment = "&comment=No Comment"
        }
        let today = "date=" + (rating?.date)!
        let entreeRating = "&entree_rating=" + String(entreeRatingStackView.starsRating)
        let lunchEntree = "&lunch_entree_string=" + (rating?.lunchEntree)!
        let phone = "&phone_ID=" + (rating?.phoneID)!
        let vegieEntree = "&vegie_entree_string=" + (rating?.vegieEntree)!
        let vegieRating = "&vegie_rating=" + String(vegieRatingStackView.starsRating)
        
        
        //creating the post parameter by concatenating the keys and values from text field
        let postParameters = today + phone + entreeRating + vegieRating + comment + lunchEntree + vegieEntree
        
        //adding the parameters to request body
        request.httpBody = postParameters.data(using: String.Encoding.utf8)
        
        
        //creating a task to send the post request
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            data, response, error in
            
            if let errorMSG = error{
                print("error is \(errorMSG)")
                return;
            }
            
            //parsing the response
            do {
                //converting resonse to NSDictionary
                let myJSON =  try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                
                //parsing the json
                if let parseJSON = myJSON {
                    
                    //creating a string
                    var msg : String!
                    
                    //getting the json response
                    msg = parseJSON["message"] as! String?
                    
                    //printing the response
                    print(msg)
                    
                }
            } catch {
                print(error)
            }
            
        }
        //executing the task
        task.resume()

        dismiss(animated: true, completion: nil)
    }
    //The two functions below move the view up so it can be seen while typing, and then down when the editing is finished.
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    

    
}
