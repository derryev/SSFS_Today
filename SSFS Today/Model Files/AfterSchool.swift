//
//  AfterSchool.swift
//  SSFS Today
//
//  Created by Brian Wilkinson on 9/14/17 on behalf of Sandy Spring Friends School
//  Copyright © 2017 SSFS. All rights reserved.
//

import Foundation

class Athletics {
    
    var dataFile = String()
    var dataArray = [String]()
    
    init() {
        fetchDataFromServer()
    }
    
    func fetchDataFromServer() {
        if let dataFile = readStringFromURL(rawFile: "https://grover.ssfs.org/menus/athletics_schedule.csv") {
            dataArray = cleanRows(stringData: dataFile)
        }
        else {
            print("Permission issue with file???")
        }
    }
    
    
    func readStringFromURL(rawFile:String)-> String? {
        if let url = NSURL(string: rawFile) {
            do {
                return try String(contentsOf: url as URL)
            } catch {
                print("Cannot load contents")
                return nil
            }
        } else {
            print("String was not a URL")
            return nil
        }
    }
    
    func cleanRows(stringData:String)->[String]{
        var cleanFile = stringData
        cleanFile = cleanFile.replacingOccurrences(of: "\r", with: "\n")
        cleanFile = cleanFile.replacingOccurrences(of: "\n\n", with: "\n")
        return cleanFile.components(separatedBy: "\n")
        
    }
    
    func getGames(date: String) -> String {
        var todaysGames = ""
        for line in dataArray {
            let currentLineArray = line.components(separatedBy: ",")
            print("date is \(date) and date in array is \(currentLineArray[0])")
            if (currentLineArray[0] == date) {
                todaysGames += currentLineArray[1] + ": " + currentLineArray[3] + " vs. " + currentLineArray[5] + " (" + currentLineArray[4] + ")" + "\n\n"
            }
        }
        if todaysGames != "" {
            return todaysGames
        } else {
            return "No games today"
        }
        
    }
    
}
