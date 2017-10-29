//
//  MainViewController.swift
//  SSFS Today
//
//  Created by Brian Wilkinson on 10/29/17.
//  Copyright © 2017 Brian Wilkinson. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    

    @IBOutlet weak var dayPicker: UIPickerView!
    
    var weekdays = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dayPicker.delegate = self
        self.dayPicker.dataSource = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 //number of columns in the picker view
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return weekdays.count //better way to do this bc it won't crash like it would if the #'s were different.
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return weekdays[row]
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "lunch" {
            if let destinationVC = segue.destination as? MenuViewController {
                destinationVC.todaysDate = weekdays[dayPicker.selectedRow(inComponent: 0)]
            }
        }
    }
    

}
