//
//  LibraryBeestroData.swift
//  SSFS Today
//
//  Created by Brian Wilkinson on 9/12/17.
//  Copyright © 2017 Brian Wilkinson. All rights reserved.
//

import Foundation

struct LibraryBeestroData {
    
    var dataFile = String()
    var dataArray = [String]()
    
    mutating func fetchDataFromServer(for date: String) -> [String] {
        dataFile = readStringFromURL(rawFile: "https://grover.ssfs.org/menus/library_beestro.csv")
        dataArray = cleanRows(stringData: dataFile)
        return returnDateInformation(date: date)
    }
    

    func readStringFromURL(rawFile:String)-> String!{
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
    
    func returnDateInformation(date: String) -> [String] {
        
        for line in dataArray {
            let currentLineArray = line.components(separatedBy: ",")
            if (currentLineArray[0] == date) {
                return currentLineArray
            }
        }
        return ["No Data Found", "No Data Found", "No Data Found", "No Data Found", "No Data Found"]
    }
    
}
