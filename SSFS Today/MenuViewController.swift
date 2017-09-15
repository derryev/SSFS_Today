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
    
    
    
    @IBOutlet weak var vegetarianEntreeLabel: UILabel!
    
    @IBOutlet weak var vegetarianEntreeText: UILabel!
    
    
    
    
    @IBOutlet weak var sidesLabel: UILabel!
    @IBOutlet weak var sidesText: UILabel!
    
    
    @IBOutlet weak var downtownDeliLabel: UILabel!
    @IBOutlet weak var downtownDeliText: UILabel!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var lunchMenuBackground: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setMenuLabels()
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(sender:)))
        leftSwipe.direction = .left
        view.addGestureRecognizer(leftSwipe)
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(sender:)))
        rightSwipe.direction = .right
        view.addGestureRecognizer(rightSwipe)
        
        if !UIAccessibilityIsReduceTransparencyEnabled() {
            lunchMenuBackground.backgroundColor = UIColor.clear
            let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.extraLight)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            //always fill the view
            blurEffectView.frame = lunchMenuBackground.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            lunchMenuBackground.addSubview(blurEffectView) //if you have more UIViews, use an insertSubview API to place it where needed
            lunchMenuBackground.layer.cornerRadius = 10.0
            lunchMenuBackground.clipsToBounds = true
        } else {
            lunchMenuBackground.backgroundColor = UIColor.white
        }
        
    }
    
    func setMenuLabels() {
       
        let day = DailyMenu()
        dateLabel.text = today.today()
        lunchEntreeText.text = day.lunchEntree
        vegetarianEntreeText.text = day.vegetarianEntree
        sidesText.text = day.sides
        downtownDeliText.text = day.downtownDeli
    }
    
    
    func handleSwipes(sender:UISwipeGestureRecognizer) {
        if (sender.direction == .left) {
            
            tabBarController?.selectedIndex = 1
            //let storyboard = UIStoryboard(name: "Main", bundle: nil)
            //let vc = storyboard.instantiateViewController(withIdentifier: "libraryBeestro")
            //self.present(vc, animated: false, completion: nil)
        }
        else  if (sender.direction == .right) {
            tabBarController?.selectedIndex = 2
            //let storyboard = UIStoryboard(name: "Main", bundle: nil)
            //let vc = storyboard.instantiateViewController(withIdentifier: "lunch")
            //self.present(vc, animated: false, completion: nil)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
