//
//  DateExtensions.swift
//  RedditApp
//
//  Created by Râmede on 16/08/21.
//

import Foundation

extension Date {
    func timeAgoDisplay() -> String {        
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: self, relativeTo: Date())
    }
}
