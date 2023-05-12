//
//  MainViewController.swift
//  SSFS Today
//
//  Created by Brian Wilkinson on 9/14/17 on behalf of Sandy Spring Friends School
//  Copyright © 2017 SSFS. All rights reserved.
//
//

import UIKit

class MainViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var mainText: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dayPicker: UIPickerView!
    @IBOutlet weak var titleGraphic: UIImageView!
    @IBOutlet weak var ratingButton: UIButton!
    
    
    // Instance variables for each of the different data types to be displayed
    var dateInfo = DateFunctions()
    var menu = Menu()
    var todaysDate: String?
    var schedule = Schedule()
    var athleticEvents = Athletics()
    var beestro = LibraryBeestroData()
    
    // variables to be used to pass to rating view
    var lunch = ""
    var vegie = ""
    
    @IBOutlet weak var daySelected: UIPageControl! //row of dots across top of view to indicate day (M-F)
    var initialPickerSelection = 0 // Variable to receive what button was pushed on previous page
    var monday: Date? // Since school weeks are keyed off Monday, need a starting point.
    
    var pickerDataSource = ["Lunch", "Schedule", "Athletics", "Beestro/Library"]
    let weekdays = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
    
    let swipeGestureLeft = UISwipeGestureRecognizer()
    let swipeGestureRight = UISwipeGestureRecognizer()
    
    /*
     The followng set of variables are used to control the opening and closing of the picker.  Initially
     the picker is hidden, but when the button is tapped, it animates opening so that a different screen
     can be selected.
    */
    @IBOutlet weak var dayPickerMarginTop: NSLayoutConstraint!
    @IBOutlet weak var dayPickerHeight: NSLayoutConstraint!
    @IBOutlet weak var topicSelectedButton: UIButton!
    
    // Variables below are used to animate the date picker when it is touched
    var dayPickerOpened: Bool = true    // state variable
    let dayPickerHeightOpened: CGFloat = 160
    let dayPickerHeightClosed: CGFloat = 0
    let dayPickerMarginTopOpened: CGFloat = 0  // 18 (see below)
    let dayPickerMarginTopClosed: CGFloat = 0
    let animateTimeStd: TimeInterval = 0.25
    let animateTimeZero: TimeInterval = 0.0
    var currentLunchRating: Rating?
    
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
        
        
        self.swipeGestureLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.swipeGestureRight.direction = UISwipeGestureRecognizer.Direction.right
        
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
        // User can only rate the lunch for the current day
        if date == dateInfo.today() {
            ratingButton.isHidden = false
        } else {
            ratingButton.isHidden = true
        }
        
        titleGraphic.image = #imageLiteral(resourceName: "menu_title")
       // The following lines set up the string formatting for the label titles and then data displayed
        let menuString = ""
        let myMutableString = NSMutableAttributedString(
            string: menuString,
            attributes: [NSAttributedString.Key.font:UIFont(
                name: "Helvetica",
                size: 17.0)!])
        
        // RGB Value of 0, 102, 71 corresponds to official SSFS Green
        let myAddedStringAttributes:[NSAttributedString.Key:Any]? = [
            NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue):UIFont(
                name: "Helvetica-Bold",
                size: 17.0)!,
            NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue):UIColor(displayP3Red: 0, green: 101/255, blue: 71/200, alpha: 1.0)
        ]
        let day = DailyMenu(forDay: date)
        let titles = ["Lunch Entrée", "Vegetarian Entrée", "Sides", "Downtown Deli"]
        let menuItems = [day.lunchEntree, day.vegetarianEntree, day.sides, day.downtownDeli]
        // Variables to be passed to rating
        let uuid = UIDevice.current.identifierForVendor?.uuidString
        currentLunchRating = Rating(for: day.lunchEntree, vegieMeal: day.vegetarianEntree, phoneID: uuid!, date: dateInfo.getDateAsString(forDate: Date()))
        lunch = day.lunchEntree
        vegie = day.vegetarianEntree
        
        for index in 0...titles.count - 1 {
            let titleString = NSAttributedString(string: titles[index] + "\n", attributes: myAddedStringAttributes)
            let timeString = NSAttributedString(string: menuItems[index] + "\n\n")
            myMutableString.append(titleString)
            myMutableString.append(timeString)
        }
        mainText.attributedText = myMutableString
        
    }
    
    func setScheduleView(weekday: String) {
        ratingButton.isHidden = true
        titleGraphic.image = #imageLiteral(resourceName: "schedule_title")
        let scheduleString = ""
        let myMutableString = NSMutableAttributedString(
            string: scheduleString,
            attributes: [NSAttributedString.Key.font:UIFont(
                name: "Helvetica",
                size: 17.0)!])
        let myAddedStringAttributes:[NSAttributedString.Key:Any]? = [
            NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue):UIFont(
                name: "Helvetica-Bold",
                size: 17.0)!,
            NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue):UIColor(displayP3Red: 0, green: 102/255, blue: 71/200, alpha: 1.0)
        ]
        if let todaysSchedule = schedule.getTodaysSchedule(date: weekday) {
            
            for block in todaysSchedule {
                print(block.title)
                let titleString = NSAttributedString(string: block.title + "\n", attributes: myAddedStringAttributes)
                let timeString = NSAttributedString(string: block.classTime + "\n\n")
                myMutableString.append(titleString)
                myMutableString.append(timeString)
                
            }
            mainText.attributedText = myMutableString
        } else {
            mainText.text = "No Schedule Information Found"
        }
        
    }
    
    func setAthleticsView(weekday: String) {
        ratingButton.isHidden = true
        titleGraphic.image = #imageLiteral(resourceName: "athletics_title")
        // TODO: When games start appearing again, will need to format the information that comes back
        // to make it look more like the other pages.  May have to adjust what comes back from the model
        // class
        let games = athleticEvents.getGames(date: weekday)
        mainText.text = games
    }
    
    func setLibraryBeestroView(weekday: String) {
        ratingButton.isHidden = true
        titleGraphic.image = #imageLiteral(resourceName: "library_beestro_title")
        let infoString = ""
        let myMutableString = NSMutableAttributedString(
            string: infoString,
            attributes: [NSAttributedString.Key.font:UIFont(
                name: "Helvetica",
                size: 17.0)!])
        let myAddedStringAttributes:[NSAttributedString.Key:Any]? = [
            NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue):UIFont(
                name: "Helvetica-Bold",
                size: 17.0)!,
            NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue):UIColor(displayP3Red: 0, green: 102/255, blue: 71/200, alpha: 1.0)
        ]
        let titles = ["Library Hours", "Library Announcements", "Beestro Hours", "Beestro Announcements"]
        let announcements = beestro.returnDateInformation(date: weekday)
        
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
        
        // Calculates which is the current day by adding an integer to the value of the most recent Monday.
        let dateToBePassed = Calendar.current.date(byAdding: .day, value: daySelected.currentPage, to: monday!)
        dateLabel.text = dateInfo.getWeekday(asString: dateToBePassed!) //Monday, Tuesday, etc.
        let day = dateInfo.getDateAsString(forDate: dateToBePassed!) // 11/13/2017, 11/14/2017, etc.
        
        //Updates the view when the picker is changed
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
        if dayPickerOpened {
            // Button with Down arrow is shown
            topicSelectedButton.setImage(#imageLiteral(resourceName: "picker_down_thin"), for: .normal)
        } else {
            // Button with Up arrow is shown
            topicSelectedButton.setImage(#imageLiteral(resourceName: "picker_up_thin"), for: .normal)
        }
    }
    
    @IBAction func rateTodaysLunch(_ sender: UIButton) {
        performSegue(withIdentifier: "ratingScreen", sender: Any?.self)
    }
    
    // Method to control the opening and closing of the picker.  Activates when the button above it is pressed
    @IBAction func dayAction(_ sender: UIButton) {
        showDayPicker(show: !dayPickerOpened, animateTime: animateTimeStd)
    }
    @IBAction func returnToMainView(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ratingScreen" {
            if let nextVC = segue.destination as? PopUpViewController {
                nextVC.rating = currentLunchRating
                
            }
        }
    }
}
