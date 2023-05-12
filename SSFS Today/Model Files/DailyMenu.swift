//
//  DailyMenu.swift
//  SSFS Today
//
//  Created by Brian Wilkinson on 9/14/17 on behalf of Sandy Spring Friends School
//  Copyright © 2017 SSFS. All rights reserved.
//
//

import Foundation

class DailyMenu {
    var lunchEntree = String()
    var vegetarianEntree = String()
    var sides = String()
    var downtownDeli = String()
    var dayMeal: String?
    var regExText = String()
    var dayOfWeek: String
    
    init(forDay dayOfWeek: String) {
        self.dayOfWeek = dayOfWeek
        let menu = Menu()
        
        if menu.aMenu != nil {
            
            var isWeekend = false
            
            if self.dayOfWeek == "Monday" {
                regExText = "MONDAY(.*?)TUESDAY"
            } else if self.dayOfWeek == "Tuesday" {
                regExText = "TUESDAY(.*?)WEDNESDAY"
            } else if self.dayOfWeek == "Wednesday" {
                regExText = "WEDNESDAY(.*?)THURSDAY"
            } else if self.dayOfWeek == "Thursday" {
                regExText = "THURSDAY(.*?)FRIDAY"
            } else if self.dayOfWeek == "Friday" {
                regExText = "FRIDAY(.*)"
            } else {
                isWeekend = true
            }
        
            self.dayMeal = String(menu.getLunch(stringToParse: menu.aMenu!, regExText: regExText))
            
        
            if (!isWeekend) {
                if self.dayOfWeek == "Monday" {
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
            //self.fridayMeal = ""
            self.regExText = ""
            self.dayOfWeek = "Monday"
        }
    }
    
}
