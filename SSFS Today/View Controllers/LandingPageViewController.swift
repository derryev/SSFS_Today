//
//  LandingPageViewController.swift
//  SSFS Today
//
//  Created by Brian Wilkinson on 11/8/17.
//  Copyright © 2017 Brian Wilkinson. All rights reserved.
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
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
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
