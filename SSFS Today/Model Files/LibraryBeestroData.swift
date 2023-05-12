//
//  LibraryBeestroData.swift
//  SSFS Today
//
//  Created by Brian Wilkinson on 9/14/17 on behalf of Sandy Spring Friends School
//  Copyright © 2017 SSFS. All rights reserved.
//

import Foundation

class LibraryBeestroData {
    
    var dataFile = String()
    var dataArray = [String]()
    
    init() {
        fetchDataFromServer()
    }
    
    func fetchDataFromServer() {
        if let dataFile = readStringFromURL(rawFile: "https://grover.ssfs.org/menus/library_beestro.csv") {
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
    
    func cleanRows(stringData:String)->[String]{
        var cleanFile = stringData
        cleanFile = cleanFile.replacingOccurrences(of: "\r", with: "\n")
        cleanFile = cleanFile.replacingOccurrences(of: "\n\n", with: "\n")
        return cleanFile.components(separatedBy: "\n")

    }
    
    func returnDateInformation(date: String) -> [String] {
        
        for line in dataArray {
            let currentLineArray = line.components(separatedBy: ",")
            if currentLineArray[0] == date {
                return currentLineArray
            }
        }
        return ["No Data Found", "No Data Found", "No Data Found", "No Data Found", "No Data Found"]
    }
    
}
