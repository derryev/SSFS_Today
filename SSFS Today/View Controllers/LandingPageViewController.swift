//
//  LandingPageViewController.swift
//  SSFS Today
//
//  Created by Brian Wilkinson on 9/14/17 on behalf of Sandy Spring Friends School
//  Copyright © 2017 SSFS. All rights reserved.
//
//

import UIKit

class LandingPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    Depending on which button was pressed, the picker on the main page will
     update to reflect the current screen.
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "lunch" {
            if let nextVC = segue.destination as? MainViewController {
                nextVC.initialPickerSelection = 0
            }
        } else if segue.identifier == "schedule" {
            if let nextVC = segue.destination as? MainViewController {
                nextVC.initialPickerSelection = 1
            }
        } else if segue.identifier == "athletics" {
            if let nextVC = segue.destination as? MainViewController {
                nextVC.initialPickerSelection = 2
            }
        } else if segue.identifier == "beestro" {
            if let nextVC = segue.destination as? MainViewController {
                nextVC.initialPickerSelection = 3
            }
        }
    }
}
