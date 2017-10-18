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
    var dayMeal: String?
    var fridayMeal: String
    var regExText = String()
    var dayOfWeek: Int
    
    init() {
        let menu = Menu()
        let today = DateFunctions()
        if menu.aMenu != nil {
            var isFriday = false
            var isWeekend = false
            self.dayOfWeek = today.getCurrentDay()!
            if self.dayOfWeek == 2 {
                regExText = "MONDAY(.*?)TUESDAY"
            } else if self.dayOfWeek == 3 {
                regExText = "TUESDAY(.*?)WEDNESDAY"
            } else if self.dayOfWeek == 4 {
                regExText = "WEDNESDAY(.*?)THURSDAY"
            } else if self.dayOfWeek == 5 {
                regExText = "THURSDAY(.*?)FRIDAY"
            } else if self.dayOfWeek == 6 {
                regExText = "FRIDAY(.*)"
                isFriday = true
            } else {
                isWeekend = true
            }
        
            if isFriday == false {
                self.dayMeal = String(menu.getLunch(stringToParse: menu.aMenu!, regExText: regExText))
                self.fridayMeal = String("") //Have to set self.fridayMeal as something, otherwise error.

            } else {
                self.fridayMeal = String(menu.getLunch(stringToParse: menu.aMenu!, regExText: regExText))
                self.dayMeal = String(menu.getLunch(stringToParse: fridayMeal, regExText: regExText)) //Every other weekday is mentioned only once in the xml file, so because Friday is mentioned twice it grabs the first Friday the first time (which is the wrong one). This runs it twice, so that the first Friday is cut out the first time, and the correct Friday is grabbed the second time.
            }
        
            if (!isWeekend) {
                if self.dayOfWeek == 2 {
                    self.lunchEntree = String(menu.getMenuItem(stringToParse: self.dayMeal!, regExText: "VEGETARIAN ENTR[ÉE]E(.*?)VEGETARIAN"))
                    let tempVegetarianEntree = String(menu.getMenuItem(stringToParse: self.dayMeal!, regExText: "VEGETARIAN ENTR[ÉE]E(.*?)SIDES"))
                    self.vegetarianEntree = String(menu.getMenuItem(stringToParse: tempVegetarianEntree, regExText: "VEGETARIAN ENTR[ÉE]E(.*)"))
                    self.sides = String(menu.getMenuItem(stringToParse: self.dayMeal!, regExText: "SIDES(.*?)(DOWNTOWN|DINNER)"))
                    self.downtownDeli = String(menu.getMenuItem(stringToParse: self.dayMeal!, regExText: "DOWNTOWN DELI(.*?)DINNER"))
                } else  {
                    self.lunchEntree = String(menu.getMenuItem(stringToParse: self.dayMeal!, regExText: "LUNCH ENTR[ÉE]E(.*?)VEGETARIAN"))
                    self.vegetarianEntree = String(menu.getMenuItem(stringToParse: self.dayMeal!, regExText: "VEGETARIAN ENTR[ÉE]E(.*?)SIDES"))
                    self.sides = String(menu.getMenuItem(stringToParse: self.dayMeal!, regExText: "SIDES(.*?)DOWNTOWN"))
                    self.downtownDeli = String(menu.getMenuItem(stringToParse: self.dayMeal!, regExText: "DOWNTOWN DELI(.*?)DINNER"))
                }
            
            } else {
                self.lunchEntree = "No Lunch Information"
                self.vegetarianEntree = "No Vegetarian Information"
                self.sides = "No Side Information"
                self.downtownDeli = "No Deli Information"
            }
        } else {
            self.lunchEntree = "No Lunch Information"
            self.vegetarianEntree = "No Vegetarian Information"
            self.sides = "No Side Information"
            self.downtownDeli = "No Deli Information"
            self.dayMeal = nil
            self.fridayMeal = ""
            self.regExText = ""
            self.dayOfWeek = 1
        }
    }
    
}
