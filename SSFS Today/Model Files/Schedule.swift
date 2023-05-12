//
//  Schedule.swift
//  SSFS Today
//
//  Created by Brian Wilkinson on 9/14/17 on behalf of Sandy Spring Friends School
//  Copyright © 2017 SSFS. All rights reserved.
//
//

import Foundation

class Schedule {
    
    var dataArray = [String]()
    
    init() {
        fetchDataFromServer()
    }
    
    func fetchDataFromServer() {
        // The file below is generated after two Python scripts are run.
        if let dataFile = readStringFromURL(rawFile: "https://grover.ssfs.org/menus/cal_file_sorted.csv") {
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
            let currentLineArray: [String?] = line.components(separatedBy: ",")
            // Check to make sure there is not a blank line in the file which would cause an out of bounds error.
            // Then check to see if the current line has today's date.
            if currentLineArray[0] != "" && currentLineArray[1] == date {
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
