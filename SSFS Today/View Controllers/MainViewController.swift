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
        daySelected.currentPage = 0
        
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
        let day = DailyMenu(forDay: date)
        var starting = 0
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let lunchEntreeTitle = "Lunch Entrée\n"
        let vegetarianEntreeTitle = "\n\nVegetarian Entrée\n"
        let sidesTitle = "\n\nSides\n"
        let downtownDeliTitle = "\n\nDowntown Deli\n"
        let lunchMenu = lunchEntreeTitle + day.lunchEntree + vegetarianEntreeTitle + day.vegetarianEntree + sidesTitle + day.sides.replacingOccurrences(of: ",", with: "\n") + downtownDeliTitle +
            day.downtownDeli
        let attributedText: NSMutableAttributedString = NSMutableAttributedString(string: lunchMenu)
        attributedText.addAttributes([NSAttributedStringKey.font: UIFont.systemFont(ofSize: 17)], range: NSRange(location:starting, length: lunchMenu.count))
        attributedText.addAttributes([NSAttributedStringKey.paragraphStyle: paragraphStyle], range: NSRange(location:starting, length: lunchMenu.count))
        attributedText.addAttributes([NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 17)], range: NSRange(location: starting, length: lunchEntreeTitle.count))
        starting += lunchEntreeTitle.count + day.lunchEntree.count
        attributedText.addAttributes([NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 17)], range: NSRange(location: starting, length: vegetarianEntreeTitle.count))
        starting += vegetarianEntreeTitle.count + day.vegetarianEntree.count
        attributedText.addAttributes([NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 17)], range: NSRange(location: starting, length: sidesTitle.count))
        starting += sidesTitle.count + day.sides.count
        attributedText.addAttributes([NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 17)], range: NSRange(location: starting, length: downtownDeliTitle.count))
        mainText.attributedText = attributedText
        
    }
    
    func setScheduleView(weekday: String) {
        if let todaysSchedule = schedule.getTodaysSchedule(date: weekday) {
            var schedString = ""
            for block in todaysSchedule {
                schedString += block.title + "\t" + block.classTime + "\n"
            }
            mainText.text = schedString
        } else {
            mainText.text = "No Schedule Information Found"
        }
        
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
