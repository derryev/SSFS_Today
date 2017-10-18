//
//  AthleticsViewController.swift
//  SSFS Today
//
//  Created by Brian Wilkinson on 9/12/17.
//  Copyright © 2017 Brian Wilkinson. All rights reserved.
//

import UIKit

class AthleticsViewController: UIViewController {

    let today = DateFunctions()

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var gamesTodayText: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(sender:)))
        leftSwipe.direction = .left
        view.addGestureRecognizer(leftSwipe)
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(sender:)))
        rightSwipe.direction = .right
        view.addGestureRecognizer(rightSwipe)
        
        // Do any additional setup after loading the view. The "let activities" sends the date to the getGames function in my after school file, and then runs it in this file.
        
        setAthleticEvents()
        let appDelegate:AppDelegate = UIApplication.shared.delegate! as! AppDelegate
        appDelegate.athleticsViewController = self
    }
    
    @objc func handleSwipes(sender:UISwipeGestureRecognizer) {
        if (sender.direction == .left) {
            tabBarController?.selectedIndex = 2
        }
        else  if (sender.direction == .right) {
            tabBarController?.selectedIndex = 0
        }
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setAthleticEvents() {
        var schedule = Athletics()
        dateLabel.text = today.today()
        if let activities = schedule.fetchDataFromServer(for: today.getDateAsString()) {
            gamesTodayText.text = activities
        } else {
            gamesTodayText.text = "No Data Found"
        }
        
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
