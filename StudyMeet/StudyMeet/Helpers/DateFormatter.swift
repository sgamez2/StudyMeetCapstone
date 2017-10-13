//
//  DateFormatter.swift
//  StudyMeet
//
//  Created by Sergio Gamez on 10/12/17.
//  Copyright © 2017 Sergio Gamez. All rights reserved.
//

import Foundation

extension Date {

    func stringValue() -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .long
        
        return formatter.string(from: self)
    }
}
