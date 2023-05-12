//
//  Block.swift
//  SSFS Today
//
//  Created by Brian Wilkinson on 9/14/17 on behalf of Sandy Spring Friends School
//  Copyright © 2017 SSFS. All rights reserved.
//
//

import Foundation

class Block {
    var title: String
    var classTime: String
    
    
    init(_ line: String) {
        // line is in the form of "C Block,10/20/2017,8:00:00,10/20/2017,8:50:00"
        let day = line.components(separatedBy: ",")
        self.title = day[0]
        let startTime = day[2]
        let endTime = day[4]
        
        self.classTime = startTime + " - " + endTime
    }
}
