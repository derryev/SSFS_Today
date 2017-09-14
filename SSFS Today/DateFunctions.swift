//
//  DateFunctions.swift
//  SSFS Today
//
//  Created by Brian Wilkinson on 9/14/17.
//  Copyright © 2017 Brian Wilkinson. All rights reserved.
//

import Foundation

class DateFunctions {
    
    let date = Date()
    let weekdays = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
    
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
        return weekdays[dayOfWeek! - 2]
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
    
    func getDateAsString() -> String {
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        
        let year =  components.year
        let month = components.month
        let day = components.day
        
        return String(month!) + "/" + String(day!) + "/" + String(year!)
    }
}

