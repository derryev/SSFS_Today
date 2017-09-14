//
//  DailyMenu.swift
//  SSFS Today
//
//  Created by Brian Wilkinson on 9/12/17.
//  Copyright © 2017 Brian Wilkinson. All rights reserved.
//

import Foundation

class DailyMenu {
    var lunchEntree = String()
    var vegetarianEntree = String()
    var sides = String()
    var downtownDeli = String()
    var dayMeal: String
    var fridayMeal: String
    var regExText = String()
    
    var menu = Menu()
    let today = DateFunctions()
    
    init() {
        
        var isFriday = false
        let dayOfWeek = today.getCurrentDay()
        if dayOfWeek! == 2 {
            regExText = "MONDAY(.*?)TUESDAY"
        } else if dayOfWeek == 3 {
            regExText = "TUESDAY(.*?)WEDNESDAY"
        } else if dayOfWeek == 4 {
            regExText = "WEDNESDAY(.*?)THURSDAY"
        } else if dayOfWeek == 5 {
            regExText = "THURSDAY(.*?)FRIDAY"
        } else if dayOfWeek == 6 {
            regExText = "FRIDAY(.*)"
            isFriday = true
        }
        
        if isFriday == false {
            self.dayMeal = String(menu.getLunch(stringToParse: menu.aMenu, regExText: regExText))
            self.fridayMeal = String("") //Have to set self.fridayMeal as something, otherwise error.
            //getDailyMeal()
        }
        else {
            self.fridayMeal = String(menu.getLunch(stringToParse: menu.aMenu, regExText: regExText))
            self.dayMeal = String(menu.getLunch(stringToParse: fridayMeal, regExText: regExText)) //Every other weekday is mentioned only once in the xml file, so because Friday is mentioned twice it grabs the first Friday the first time (which is the wrong one). This runs it twice, so that the first Friday is cut out the first time, and the correct Friday is grabbed the second time.
            //getDailyMeal()
        }
        
        lunchEntree = String(menu.getMenuItem(stringToParse: dayMeal, regExText: "LUNCH ENTRÉE(.*?)VEGETARIAN"))
        vegetarianEntree = String(menu.getMenuItem(stringToParse: dayMeal, regExText: "VEGETARIAN ENTRÉE(.*?)SIDES"))
        sides = String(menu.getMenuItem(stringToParse: dayMeal, regExText: "SIDES(.*?)DOWNTOWN"))
        downtownDeli = String(menu.getMenuItem(stringToParse: dayMeal, regExText: "DOWNTOWN DELI(.*?)DINNER"))
        
    }
    
}
