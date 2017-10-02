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
    var dayOfWeek: Int
    
    var menu = Menu()
    let today = DateFunctions()
    
    init() {
        
        var isFriday = false
        var isWeekend = false
        dayOfWeek = today.getCurrentDay()!
        if dayOfWeek == 2 {
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
        } else {
            isWeekend = true
        }
        
        if isFriday == false {
            self.dayMeal = String(menu.getLunch(stringToParse: menu.aMenu, regExText: regExText))
            self.fridayMeal = String("") //Have to set self.fridayMeal as something, otherwise error.
        }
        else {
            self.fridayMeal = String(menu.getLunch(stringToParse: menu.aMenu, regExText: regExText))
            self.dayMeal = String(menu.getLunch(stringToParse: fridayMeal, regExText: regExText)) //Every other weekday is mentioned only once in the xml file, so because Friday is mentioned twice it grabs the first Friday the first time (which is the wrong one). This runs it twice, so that the first Friday is cut out the first time, and the correct Friday is grabbed the second time.
            
        }
        
        if (!isWeekend) {
            if dayOfWeek == 2 {
                lunchEntree = String(menu.getMenuItem(stringToParse: dayMeal, regExText: "VEGETARIAN ENTR[ÉE]E(.*?)VEGETARIAN"))
                let tempVegetarianEntree = String(menu.getMenuItem(stringToParse: dayMeal, regExText: "VEGETARIAN ENTR[ÉE]E(.*?)SIDES"))
                vegetarianEntree = String(menu.getMenuItem(stringToParse: tempVegetarianEntree, regExText: "VEGETARIAN ENTR[ÉE]E(.*)"))
                sides = String(menu.getMenuItem(stringToParse: dayMeal, regExText: "SIDES(.*?)(DOWNTOWN|DINNER)"))
            } else {
                lunchEntree = String(menu.getMenuItem(stringToParse: dayMeal, regExText: "LUNCH ENTR[ÉE]E(.*?)VEGETARIAN"))
                vegetarianEntree = String(menu.getMenuItem(stringToParse: dayMeal, regExText: "VEGETARIAN ENTR[ÉE]E(.*?)SIDES"))
                sides = String(menu.getMenuItem(stringToParse: dayMeal, regExText: "SIDES(.*?)DOWNTOWN"))
            }
            downtownDeli = String(menu.getMenuItem(stringToParse: dayMeal, regExText: "DOWNTOWN DELI(.*?)DINNER"))
        } else {
            lunchEntree = "No Lunch Information"
            vegetarianEntree = "No Vegetarian Today"
            sides = "No Side Today"
            downtownDeli = "No Deli Today"
        }
        
        
        
    }
    
}
