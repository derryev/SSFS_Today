//
//  AthleticsViewController.swift
//  SSFS Today
//
//  Created by Brian Wilkinson on 9/12/17.
//  Copyright © 2017 Brian Wilkinson. All rights reserved.
//

import UIKit

class AthleticsViewController: UIViewController {

    let afterSchool = AfterS()
    let today = DateFunctions()

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var gamesTodayText: UILabel!
    @IBOutlet weak var athleticsBackground: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let activities = afterSchool.getGames(dayOfWeek: today.getCurrentWeekDay()!)
        gamesTodayText.text = activities
        dateLabel.text = today.today()
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(sender:)))
        leftSwipe.direction = .left
        view.addGestureRecognizer(leftSwipe)
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(sender:)))
        rightSwipe.direction = .right
        view.addGestureRecognizer(rightSwipe)
        
        // Do any additional setup after loading the view. The "let activities" sends the date to the getGames function in my after school file, and then runs it in this file.
        
        if !UIAccessibilityIsReduceTransparencyEnabled() {
            athleticsBackground.backgroundColor = UIColor.clear
            let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.extraLight)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            //always fill the view
            blurEffectView.frame = athleticsBackground.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            athleticsBackground.addSubview(blurEffectView) //if you have more UIViews, use an insertSubview API to place it where needed
            
            athleticsBackground.layer.cornerRadius = 10.0
            athleticsBackground.clipsToBounds = true
        } else {
            athleticsBackground.backgroundColor = UIColor.white
        }
    }
    
    @objc func handleSwipes(sender:UISwipeGestureRecognizer) {
        if (sender.direction == .left) {
            
            tabBarController?.selectedIndex = 2
            //let storyboard = UIStoryboard(name: "Main", bundle: nil)
            //let vc = storyboard.instantiateViewController(withIdentifier: "libraryBeestro")
            //self.present(vc, animated: false, completion: nil)
        }
        else  if (sender.direction == .right) {
            tabBarController?.selectedIndex = 0
            //let storyboard = UIStoryboard(name: "Main", bundle: nil)
            //let vc = storyboard.instantiateViewController(withIdentifier: "lunch")
            //self.present(vc, animated: false, completion: nil)
        }
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
