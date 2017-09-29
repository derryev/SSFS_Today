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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(sender:)))
        leftSwipe.direction = .left
        view.addGestureRecognizer(leftSwipe)
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(sender:)))
        rightSwipe.direction = .right
        view.addGestureRecognizer(rightSwipe)
        
        setViewLabelData()
        let appDelegate:AppDelegate = UIApplication.shared.delegate! as! AppDelegate
        appDelegate.beestroViewController = self
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setViewLabelData() {
        var beestroLibraryHours = LibraryBeestroData()
        yarnallData = beestroLibraryHours.fetchDataFromServer(for: today.getDateAsString())
        dateLabel.text = today.today()
        libraryHours.text = yarnallData[1]
        libAnnouncements.text = yarnallData[2]
        beestroHoursLabel.text = yarnallData[3]
        announcementsLabel.text = yarnallData[4]
        
    }
    
    @objc func handleSwipes(sender:UISwipeGestureRecognizer) {
        if (sender.direction == .left) {
            tabBarController?.selectedIndex = 0
        }
        else  if (sender.direction == .right) {
            tabBarController?.selectedIndex = 1
        }
    }
    

}
