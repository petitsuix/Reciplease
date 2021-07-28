//
//  DateFormatter.swift
//  Reciplease
//
//  Created by Richardier on 19/07/2021.
//

import Foundation

extension Double {
    
    // ⬇︎ Formats raw time into readable time units
    func timeFormatter() -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated // "h", "m", "s"
        formatter.maximumUnitCount = 1 // eg: 1h25m will show 1h
        let timeToChange = self * 60 // default count is seconds
        guard let formattedString = formatter.string(from: timeToChange) else { return "-" }
        return formattedString
    }
}
