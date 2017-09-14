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
    let today = DateFunctions()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateLabel.text = today.today()
        let currentDate = today.getDateAsString() // returns date as 9/13/2017

        let beestroLibraryHours = LibraryBeestroData()
        
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
    
    
    func setViewLabelData() {
        libraryHours.text = yarnallData[1]
        beestroHoursLabel.text = yarnallData[2]
        announcementsLabel.text = yarnallData[3]
        
    }
    

}
