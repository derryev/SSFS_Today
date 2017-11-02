//
//  MainViewController.swift
//  SSFS Today
//
//  Created by Brian Wilkinson on 10/29/17.
//  Copyright © 2017 Brian Wilkinson. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var mainText: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dayPicker: UIPickerView!
    var dateInfo = DateFunctions()
    var monday: Date?
    var menu = Menu()
    var todaysDate: String?
    var schedule = Schedule()
    var athleticEvents = Athletics()
    var beestro = LibraryBeestroData()
    
    var pickerDataSource = [["Lunch", "Schedule", "Athletics", "Beestro/Library", "Wildezine"],["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dayPicker.delegate = self
        self.dayPicker.dataSource = self
        monday = dateInfo.get(direction: .Previous, "Monday", considerToday: true)
        // Do any additional setup after loading the view.
        updateView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2 //number of columns in the picker view
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[component][row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        updateView()
    }
    
    func setMenuLabels(forDay date: String) {
        let day = DailyMenu(forDay: date)
        var starting = 0
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let lunchMenu = "Lunch Entree\n" + day.lunchEntree + "\n\nVegetarian Entree\n" + day.vegetarianEntree + "\n\nSides\n" + day.sides.replacingOccurrences(of: ",", with: "\n") + "\n\nDowntown Deli\n" +
            day.downtownDeli
        let attributedText: NSMutableAttributedString = NSMutableAttributedString(string: lunchMenu)
        attributedText.addAttributes([NSAttributedStringKey.font: UIFont.systemFont(ofSize: 17)], range: NSRange(location:starting, length: lunchMenu.count))
        attributedText.addAttributes([NSAttributedStringKey.paragraphStyle: paragraphStyle], range: NSRange(location:starting, length: lunchMenu.count))
        attributedText.addAttributes([NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 17)], range: NSRange(location: starting, length: 12))
        starting += 13 + day.lunchEntree.count
        attributedText.addAttributes([NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 17)], range: NSRange(location: starting, length: 20))
        starting += 21 + day.vegetarianEntree.count
        attributedText.addAttributes([NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 17)], range: NSRange(location: starting, length: 7))
        starting += 8 + day.sides.count
        attributedText.addAttributes([NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 17)], range: NSRange(location: starting, length: 14))
        mainText.attributedText = attributedText
        
    }
    
    func setScheduleView(weekday: String) {
        let todaysSchedule = schedule.getTodaysSchedule(date: weekday)
        var schedString = ""
        for block in todaysSchedule! {
            schedString += block.title + "\t" + block.classTime + "\n"
        }
        mainText.text = schedString
    }
    
    func setAthleticsView(weekday: String) {
        let games = athleticEvents.getGames(date: weekday)
        mainText.text = games
    }
    
    func setLibraryBeestroView(weekday: String) {
        let titles = ["Library Hours", "Library Announcements", "Beestro Hours", "Beestro Announcements"]
        let announcements = beestro.returnDateInformation(date: weekday)
        var info = ""
        for index in 0...titles.count - 1 {
            info += titles[index] + "\n" + announcements[index + 1] + "\n\n"
        }
        mainText.text = info
    }
    
    func updateView() {
        dateLabel.text = pickerDataSource[1][dayPicker.selectedRow(inComponent: 1)]
        let dateToBePassed = Calendar.current.date(byAdding: .day, value: dayPicker.selectedRow(inComponent: 1), to: monday!)
        let day = dateInfo.getDateAsString(forDate: dateToBePassed!)
        switch dayPicker.selectedRow(inComponent: 0) {
        case 0:
            let daySelected = pickerDataSource[1][dayPicker.selectedRow(inComponent: 1)]
            setMenuLabels(forDay: daySelected)
        case 1:
            setScheduleView(weekday: day)
        case 2:
            setAthleticsView(weekday: day)
        case 3:
            setLibraryBeestroView(weekday: day)
        case 4:
            performSegue(withIdentifier: "wildezine", sender: nil)
        default:
            print("Fill in later")
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dateToBePassed = Calendar.current.date(byAdding: .day, value: dayPicker.selectedRow(inComponent: 0), to: monday!)
        if segue.identifier == "lunch" {
            if let destinationVC = segue.destination as? MenuViewController {
                
                destinationVC.todaysDate = pickerDataSource[0][dayPicker.selectedRow(inComponent: 0)]
            }
        } else if segue.identifier == "athletics" {
            if let destinationVC = segue.destination as? AthleticsViewController {
                destinationVC.todaysDate = dateToBePassed
            }
        } else if segue.identifier == "schedule" {
            if let destinationVC = segue.destination as? ScheduleTableViewController {
                destinationVC.todaysDate = dateToBePassed
            }
        } else if segue.identifier == "beestro" {
            if let destinationVC = segue.destination as? LibraryBeestroViewController {
                destinationVC.todaysDate = dateToBePassed
            }
        }
    }
    

}
