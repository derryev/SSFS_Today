//
//  Schedule.swift
//  SSFS Today
//
//  Created by Brian Wilkinson on 10/19/17.
//  Copyright © 2017 Brian Wilkinson. All rights reserved.
//

import Foundation

class Schedule {
    
    var dataArray = [String]()
    
    init() {
        fetchDataFromServer()
    }
    
    func fetchDataFromServer() {
        if let dataFile = readStringFromURL(rawFile: "https://grover.ssfs.org/menus/calendar.csv") {
            dataArray = cleanRows(stringData: dataFile)
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
    
    func cleanRows(stringData: String)->[String]{
        var cleanFile = stringData
        cleanFile = cleanFile.replacingOccurrences(of: "\r", with: "\n")
        cleanFile = cleanFile.replacingOccurrences(of: "\n\n", with: "\n")
        return cleanFile.components(separatedBy: "\n")
        
    }
    
    func getTodaysSchedule(date: String) -> [Block]? {
        var todaysSchedule = [Block]()
        for line in dataArray {
            let currentLineArray = line.components(separatedBy: ",")
            if (currentLineArray[1] == date) {
                let nextBlock = Block(line)
                todaysSchedule.append(nextBlock)
            }
        }
        if todaysSchedule.count == 0 {
            return nil
        } else {
            return todaysSchedule
        }
    }
}
