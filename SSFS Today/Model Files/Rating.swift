//
//  Rating.swift
//  SSFS Today
//
//  Created by Brian Wilkinson on 5/23/18.
//  Copyright © 2018 Brian Wilkinson. All rights reserved.
//

import Foundation

class Rating
{
    // This class should be initialized with the lunch data
    // and the phone data.
    // The ratings will be added on the rating view

    var phoneID: String
    var lunchEntree: String
    var vegieEntree: String
    var date: String
    
    init(for entree: String, vegieMeal: String, phoneID: String, date:String) {
        lunchEntree = entree
        self.date = date
        self.phoneID = phoneID
        vegieEntree = vegieMeal
    }
    
}
