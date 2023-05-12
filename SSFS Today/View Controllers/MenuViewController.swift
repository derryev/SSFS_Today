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
    @IBOutlet weak var lunchMenuText: UITextView!
    var todaysDate: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setMenuLabels()
        let _:AppDelegate = UIApplication.shared.delegate! as! AppDelegate
        //appDelegate.lunchViewController = self
        
    }
    
    func setMenuLabels() {
        let day = DailyMenu(forDay: todaysDate!)
        dateLabel.text = todaysDate!
        var starting = 0
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let lunchMenu = "Lunch Entree\n" + day.lunchEntree + "\n\nVegetarian Entree\n" + day.vegetarianEntree + "\n\nSides\n" + day.sides.replacingOccurrences(of: ",", with: "\n") + "\n\nDowntown Deli\n" +
            day.downtownDeli
        let attributedText: NSMutableAttributedString = NSMutableAttributedString(string: lunchMenu)
        attributedText.addAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)], range: NSRange(location:starting, length: lunchMenu.count))
        attributedText.addAttributes([NSAttributedString.Key.paragraphStyle: paragraphStyle], range: NSRange(location:starting, length: lunchMenu.count))
        attributedText.addAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17)], range: NSRange(location: starting, length: 12))
        starting += 13 + day.lunchEntree.count
        attributedText.addAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17)], range: NSRange(location: starting, length: 20))
        starting += 21 + day.vegetarianEntree.count
        attributedText.addAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17)], range: NSRange(location: starting, length: 7))
        starting += 8 + day.sides.count
        attributedText.addAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17)], range: NSRange(location: starting, length: 14))
        lunchMenuText.attributedText = attributedText
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
