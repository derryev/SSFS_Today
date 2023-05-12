//
//  DateFunctions.swift
//  SSFS Today
//
//  Created by Brian Wilkinson on 9/14/17 on behalf of Sandy Spring Friends School
//  Copyright © 2017 SSFS. All rights reserved.
//

import Foundation

class DateFunctions {
    
    let date = Date()
    let weekdays = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    
    enum SearchDirection {
        case Next
        case Previous
        
        var calendarOptions: NSCalendar.Options {
            switch self {
            case .Next:
                return .matchNextTime
            case .Previous:
                return [.searchBackwards, .matchNextTime]
            }
        }
    }
    func getCurrentDay()->Int?{
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .weekday], from: date)
        let day = components.weekday
        
        return day
        // code from http://stackoverflow.com/questions/28861091/getting-the-current-day-of-the-week-in-swift .This function gets the current day of the week and returns it as Optional() with the corresponding number for the day of the week it is. For example Optional(2) is Monday and Optional(1) is Sunday.
    }
    
    func today() -> String {
        let dayOfWeek = getCurrentDay()
        
        // dayOfWeek starts at 2 (becuase Monday is returned as Optional(2) in the getCurrentDay function. So to make it correspond with the weekdays variable, there is a "- 2" so that the weekdays align.

        return weekdays[dayOfWeek! - 1]
    }
    
    func getCurrentWeekDay()->Int?{
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        let day = components.day
        // pasted into here to get day of the week at the top of the screen (See MenuViewController)
        
        return day
        // code from http://stackoverflow.com/questions/28861091/getting-the-current-day-of-the-week-in-swift . This code gets the day of the current date as an integer (Unlike code in menu view controller, this returns the date instead of the day of week).
    }
    
    func getDateAsString(forDate: Date) -> String {
        // let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: forDate)
        
        let year =  components.year
        let month = components.month
        let day = components.day
        
        return String(month!) + "/" + String(day!) + "/" + String(year!)
    }
    
    func getWeekDaysInEnglish() -> [String] {
        let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        calendar.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
        return calendar.weekdaySymbols
    }
    
    
    func get(direction: SearchDirection, _ dayName: String, considerToday consider: Bool = true) -> Date {
        let weekdaysName = getWeekDaysInEnglish()
        
        assert(weekdaysName.contains(dayName), "weekday symbol should be in form \(weekdaysName)")
        
        let nextWeekDayIndex = weekdaysName.firstIndex(of: dayName)! + 1 // weekday is in form 1 ... 7 where as index is 0 ... 6
        
        let today = Date()
        
        let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        
        if consider && calendar.component(.weekday, from: today as Date) == nextWeekDayIndex {
            return today
        }
        
        let nextDateComponent = NSDateComponents()
        nextDateComponent.weekday = nextWeekDayIndex
        
        
        let date = calendar.nextDate(after: today as Date, matching: nextDateComponent as DateComponents, options: direction.calendarOptions)
        return date!
    }
    
    func getWeekday(asString forDate: Date) -> String {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.weekday], from: forDate)
        let day = components.weekday
        // pasted into here to get day of the week at the top of the screen (See MenuViewController)
        
        return weekdays[day! - 1]
    }
}

