//
//  LibraryBeestroViewController.swift
//  SSFS Today
//
//  Created by Brian Wilkinson on 9/12/17.
//  Copyright © 2017 Brian Wilkinson. All rights reserved.
//

import UIKit

class LibraryBeestroViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var libraryHours: UILabel!
    @IBOutlet weak var beestroHoursLabel: UILabel!
    @IBOutlet weak var announcementsLabel: UILabel!
    @IBOutlet weak var beestroBackground: UIView!
    
    var yarnallData = [String]()
    var weekdays = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dayOfWeek()
        let currentDate = getDateAsString()

        let beestroLibraryHours = LibraryBeestroData(stringURL: "https://grover.ssfs.org/menus/library_beestro.csv")
        
        yarnallData = beestroLibraryHours.returnDateInformation(date: currentDate)
        
        if !UIAccessibilityIsReduceTransparencyEnabled() {
            beestroBackground.backgroundColor = UIColor.clear
            let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.extraLight)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            //always fill the view
            blurEffectView.frame = beestroBackground.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            beestroBackground.addSubview(blurEffectView) //if you have more UIViews, use an insertSubview API to place it where needed
            
            beestroBackground.layer.cornerRadius = 10.0
            beestroBackground.clipsToBounds = true
        } else {
            beestroBackground.backgroundColor = UIColor.white
        }
        
        setViewLabelData()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dayOfWeek() {
        let dayOfWeek = getCurrentDate()
        dateLabel.text = weekdays[dayOfWeek! - 2]
        // pasted into here to get day of the week at the top of the screen (See MenuViewController)
    }
    
    func getCurrentDate()->Int?{
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .weekday], from: date)
        let day = components.weekday
        // pasted into here to get day of the week at the top of the screen (See MenuViewController)
        
        return day
        // code from http://stackoverflow.com/questions/28861091/getting-the-current-day-of-the-week-in-swift . This code gets the day of the current date as an integer (Unlike code in menu view controller, this returns the date instead of the day of week).
    }
    
    func getDateAsString() -> String {
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        
        let year =  components.year
        let month = components.month
        let day = components.day
        
        return String(month!) + "/" + String(day!) + "/" + String(year!)
    }
    
    func setViewLabelData() {
        libraryHours.text = yarnallData[1]
        beestroHoursLabel.text = yarnallData[2]
        announcementsLabel.text = yarnallData[3]
        
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
