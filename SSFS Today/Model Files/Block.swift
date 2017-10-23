//
//  Block.swift
//  SSFS Today
//
//  Created by Brian Wilkinson on 10/20/17.
//  Copyright © 2017 Brian Wilkinson. All rights reserved.
//

import Foundation

class Block {
    var title: String
    var classTime: String
    
    
    init(_ line: String) {
        var times: [String: String] = ["0:00:00": "", "8:00:00": "8:00", "8:45:00": "8:45", "8:50:00": "8:50", "8:55:00": "8:55", "10:00:00": "10:00", "10:05:00": "10:05", "10:15:00": "10:15", "10:20:00": "10:20", "11:00:00": "11:00", "11:05:00": "11:05", "11:10:00": "11:10", "11:15:00": "11:15", "11:45:00": "11:45", "11:50:00": "11:50", "11:55:00": "11:55", "12:00:00": "12:00", "12:20:00": "12:20", "12:40:00": "12:40", "13:00:00": "1:00", "13:20:00": "1:20", "13:45:00": "1:45", "13:50:00": "1:50", "14:10:00": "2:10", "14:15:00": "2:15", "14:35:00": "2:35", "15:05:00": "3:05", "15:35:00": "3:35"]
        // line is in the form of "C Block,10/20/2017,8:00:00,10/20/2017,8:50:00,FALSE"
        let day = line.components(separatedBy: ",")
        self.title = day[0]
        let startTime = times[day[2]]
        let endTime = times[day[4]]
        self.classTime = startTime! + " - " + endTime!
        
    }
}
