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
    @IBOutlet weak var daySelected: UIPageControl!
    var initialPickerSelection = 0
    
    var pickerDataSource = ["Lunch", "Schedule", "Athletics", "Beestro/Library"]
    let weekdays = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
    let swipeGestureLeft = UISwipeGestureRecognizer()
    let swipeGestureRight = UISwipeGestureRecognizer()
    
    @IBOutlet weak var dayPickerMarginTop: NSLayoutConstraint!
    @IBOutlet weak var dayPickerHeight: NSLayoutConstraint!
    @IBOutlet weak var topicSelectedButton: UIButton!
    
    var dayPickerOpened: Bool = true    // state variable
    let dayPickerHeightOpened: CGFloat = 160
    let dayPickerHeightClosed: CGFloat = 0
    let dayPickerMarginTopOpened: CGFloat = 0  // 18 (see below)
    let dayPickerMarginTopClosed: CGFloat = 0
    let animateTimeStd: TimeInterval = 0.25
    let animateTimeZero: TimeInterval = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dayPicker.delegate = self
        self.dayPicker.dataSource = self
        // dateInfo.getCurrentDay() returns an int between 1 (Sunday) and 7 (Saturday).  Need to subtract 2
        // to align with the Page control which goes from 0 -4 (M-F).
        let currentDayOfWeek = dateInfo.getCurrentDay()! - 2
        if currentDayOfWeek >= 0 && currentDayOfWeek < 5 {
            daySelected.currentPage = currentDayOfWeek
        } else {
            daySelected.currentPage = 0
        }
        
        
        self.swipeGestureLeft.direction = UISwipeGestureRecognizerDirection.left
        self.swipeGestureRight.direction = UISwipeGestureRecognizerDirection.right
        
        // add gesture target
        self.swipeGestureLeft.addTarget(self, action: #selector(handleSwipeLeft(sender:)))
        self.swipeGestureRight.addTarget(self, action: #selector(handleSwipeRight(sender:)))
        
        // add gesture in to view
        self.view.addGestureRecognizer(self.swipeGestureLeft)
        self.view.addGestureRecognizer(self.swipeGestureRight)
        monday = dateInfo.get(direction: .Previous, "Monday", considerToday: true)
        // Do any additional setup after loading the view.
        dayPicker.selectRow(initialPickerSelection, inComponent: 0, animated: false)
        showDayPicker(show: !dayPickerOpened, animateTime: animateTimeStd)
        updateView()
    }
    
    @objc func handleSwipeLeft(sender:UISwipeGestureRecognizer) {
        if daySelected.currentPage < daySelected.numberOfPages {
            daySelected.currentPage += 1
            updateView()
        }
    }
    
    @objc func handleSwipeRight(sender:UISwipeGestureRecognizer) {
        if daySelected.currentPage > 0 {
            daySelected.currentPage -= 1
            updateView()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 //number of columns in the picker view
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        updateView()
    }
    
    func setMenuLabels(forDay date: String) {
        let menuString = ""
        let myMutableString = NSMutableAttributedString(
            string: menuString,
            attributes: [NSAttributedStringKey.font:UIFont(
                name: "Helvetica",
                size: 17.0)!])
        let myAddedStringAttributes:[NSAttributedStringKey:Any]? = [
            NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue):UIFont(
                name: "Helvetica-Bold",
                size: 17.0)!,
            NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue):UIColor(displayP3Red: 0, green: 102/255, blue: 71/200, alpha: 1.0)
        ]
        let day = DailyMenu(forDay: date)
        let titles = ["Lunch Entrée", "Vegetarian Entrée",  "Sides","Downtown Deli"]
        let menuItems = [day.lunchEntree, day.vegetarianEntree, day.sides, day.downtownDeli]
        for index in 0...titles.count - 1 {
            let titleString = NSAttributedString(string: titles[index] + "\n", attributes: myAddedStringAttributes)
            let timeString = NSAttributedString(string: menuItems[index] + "\n\n")
            myMutableString.append(titleString)
            myMutableString.append(timeString)
        }
        mainText.attributedText = myMutableString
        
    }
    
    func setScheduleView(weekday: String) {
        let scheduleString = ""
        let myMutableString = NSMutableAttributedString(
            string: scheduleString,
            attributes: [NSAttributedStringKey.font:UIFont(
                name: "Helvetica",
                size: 17.0)!])
        let myAddedStringAttributes:[NSAttributedStringKey:Any]? = [
            NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue):UIFont(
                name: "Helvetica-Bold",
                size: 17.0)!,
            NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue):UIColor(displayP3Red: 0, green: 102/255, blue: 71/200, alpha: 1.0)
        ]
        if let todaysSchedule = schedule.getTodaysSchedule(date: weekday) {
            //var schedString = ""
            for block in todaysSchedule {
                print(block.title)
                let titleString = NSAttributedString(string: block.title + "\n", attributes: myAddedStringAttributes)
                let timeString = NSAttributedString(string: block.classTime + "\n\n")
                myMutableString.append(titleString)
                myMutableString.append(timeString)
                
                //schedString += block.title + "\t" + block.classTime + "\n"
            }
            mainText.attributedText = myMutableString
        } else {
            mainText.text = "No Schedule Information Found"
        }
        
    }
    
    func setAthleticsView(weekday: String) {
        let games = athleticEvents.getGames(date: weekday)
        mainText.text = games
    }
    
    func setLibraryBeestroView(weekday: String) {
        let infoString = ""
        let myMutableString = NSMutableAttributedString(
            string: infoString,
            attributes: [NSAttributedStringKey.font:UIFont(
                name: "Helvetica",
                size: 17.0)!])
        let myAddedStringAttributes:[NSAttributedStringKey:Any]? = [
            NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue):UIFont(
                name: "Helvetica-Bold",
                size: 17.0)!,
            NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue):UIColor(displayP3Red: 0, green: 102/255, blue: 71/200, alpha: 1.0)
        ]
        let titles = ["Library Hours", "Library Announcements", "Beestro Hours", "Beestro Announcements"]
        let announcements = beestro.returnDateInformation(date: weekday)
        //var info = ""
        for index in 0...titles.count - 1 {
            let titleString = NSAttributedString(string: titles[index] + "\n", attributes: myAddedStringAttributes)
            let timeString = NSAttributedString(string: announcements[index + 1] + "\n\n")
            myMutableString.append(titleString)
            myMutableString.append(timeString)
        }
        mainText.attributedText = myMutableString
    }
    
    func updateView() {
        setButtonTitle() // Makes sure the arrow points the correct direction depending on if the picker is visible or not.
        let dateToBePassed = Calendar.current.date(byAdding: .day, value: daySelected.currentPage, to: monday!)
        dateLabel.text = dateInfo.getWeekday(asString: dateToBePassed!)
        let day = dateInfo.getDateAsString(forDate: dateToBePassed!)
        switch dayPicker.selectedRow(inComponent: 0) {
        case 0:
            let currentDay = weekdays[daySelected.currentPage]
            setMenuLabels(forDay: currentDay)
        case 1:
            setScheduleView(weekday: day)
        case 2:
            setAthleticsView(weekday: day)
        case 3:
            setLibraryBeestroView(weekday: day)
        default:
            print("Fill in later")
        }
    }
    
    func showDayPicker(show: Bool, animateTime: TimeInterval) {
        // set state variable
        dayPickerOpened = show
        setButtonTitle()
        // this makes the datePicker disappear from the screen BUT leaves the space still occupied
        // this is not strictly necessary but it will make the appearance more tidy
        self.dayPicker.isHidden = !show
        
        // animate the datePicker open/hide - this is the where the constraints are modified
        UIView.animate(withDuration: animateTime, animations: {
            
            // toggle open/close the datePicker
            self.dayPickerHeight.constant = (show ? self.dayPickerHeightOpened : self.dayPickerHeightClosed)
            
            // toggle open/close the datePicker top margin
            // as it turns out for me, it looked better in my set up to have top margin zero all the time but I'm leaving the code here in case I need it later
            self.dayPickerMarginTop.constant = (show ? self.dayPickerMarginTopOpened : self.dayPickerMarginTopClosed)
            
            // this I understand tells the view to update
            self.view.layoutIfNeeded()
        })
    }
    
    func setButtonTitle() {
        var buttonTitle = ""
        if dayPickerOpened {
            buttonTitle = pickerDataSource[dayPicker.selectedRow(inComponent: 0)] + " ↓"
        } else {
            buttonTitle = pickerDataSource[dayPicker.selectedRow(inComponent: 0)] + " ↑"
        }
        topicSelectedButton.setTitle(buttonTitle, for: .normal)
    }
    
    @IBAction func dayAction(_ sender: UIButton) {
        showDayPicker(show: !dayPickerOpened, animateTime: animateTimeStd)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    

}
