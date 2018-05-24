//
//  PopUpViewController.swift
//  SSFS Today
//
//  Created by Brian Wilkinson on 5/23/18.
//  Copyright © 2018 Brian Wilkinson. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {
    //URL to our web service
    let URL_SAVE_RATING = "https://grover.ssfs.org/menus/ratings/createrating.php"
    
    var rating: Rating?
    
    @IBOutlet weak var entreeRatingStackView: RatingController!
    
    @IBOutlet weak var vegieRatingStackView: RatingController!
    
    @IBOutlet weak var commentField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        // TODO: Check to make sure comment field is not blank first
        let comment = "comment=" + commentField.text!
        let today = "&date=" + (rating?.date)!
        let entreeRating = "&entree_rating=" + String(entreeRatingStackView.starsRating)
        let lunchEntree = "&lunch_entree_string=" + (rating?.lunchEntree)!
        let phone = "&phone_ID=" + (rating?.phoneID)!
        let vegieEntree = "&vegie_entree_string=" + (rating?.vegieEntree)!
        let vegieRating = "&vegie_rating=" + String(vegieRatingStackView.starsRating)
        
        
        //creating the post parameter by concatenating the keys and values from text field
        let postParameters = comment + today + entreeRating + lunchEntree + phone + vegieEntree + vegieRating
        
        //adding the parameters to request body
        request.httpBody = postParameters.data(using: String.Encoding.utf8)
        
        
        //creating a task to send the post request
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            data, response, error in
            
            if error != nil{
                print("error is \(error)")
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
    
}
