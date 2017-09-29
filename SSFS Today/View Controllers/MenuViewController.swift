//
//  MenuViewController.swift
//  SSFS Today
//
//  Created by Brian Wilkinson on 9/12/17.
//  Copyright © 2017 Brian Wilkinson. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    var menu = Menu()
    let today = DateFunctions()
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var lunchEntreeText: UILabel!
    @IBOutlet weak var vegetarianEntreeText: UILabel!
    @IBOutlet weak var sidesText: UILabel!
    @IBOutlet weak var downtownDeliText: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setMenuLabels()
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(sender:)))
        leftSwipe.direction = .left
        view.addGestureRecognizer(leftSwipe)
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(sender:)))
        rightSwipe.direction = .right
        view.addGestureRecognizer(rightSwipe)
    
        let appDelegate:AppDelegate = UIApplication.shared.delegate! as! AppDelegate
        appDelegate.lunchViewController = self
        
    }
    
    func setMenuLabels() {
        let day = DailyMenu()
        dateLabel.text = today.today()
        lunchEntreeText.text = day.lunchEntree
        vegetarianEntreeText.text = day.vegetarianEntree
        sidesText.text = day.sides.replacingOccurrences(of: ",", with: "\n")
        downtownDeliText.text = day.downtownDeli
    }
    
    
    @objc func handleSwipes(sender:UISwipeGestureRecognizer) {
        if (sender.direction == .left) {
            tabBarController?.selectedIndex = 1
        }
        else  if (sender.direction == .right) {
            tabBarController?.selectedIndex = 2
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
