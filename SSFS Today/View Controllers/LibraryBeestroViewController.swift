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
    @IBOutlet weak var libAnnouncements: UILabel!
    
    var yarnallData = [String]()
    let today = DateFunctions()
    var todaysDate: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setViewLabelData()
        let appDelegate:AppDelegate = UIApplication.shared.delegate! as! AppDelegate
        //appDelegate.beestroViewController = self
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
//    func setViewLabelData() {
//        var beestroLibraryHours = LibraryBeestroData()
//        yarnallData = beestroLibraryHours.fetchDataFromServer(for: today.getDateAsString(forDate: todaysDate!))
//        dateLabel.text = today.getWeekday(asString: todaysDate!)
//        libraryHours.text = yarnallData[1]
//        libAnnouncements.text = yarnallData[2]
//        beestroHoursLabel.text = yarnallData[3]
//        announcementsLabel.text = yarnallData[4]
//
//    }
    

}
