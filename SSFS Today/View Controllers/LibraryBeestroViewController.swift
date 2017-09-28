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
        libraryHours.text = yarnallData[1]
        beestroHoursLabel.text = yarnallData[2]
        announcementsLabel.text = yarnallData[3]
        
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
