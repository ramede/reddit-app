//
//  DateUtils.swift
//  RedditApp
//
//  Created by Râmede on 16/08/21.
//

import Foundation

struct DateUtils {
    static public func castToDate(_ date: Int) -> Date {
        let timeInterval = Double(date)
        return Date(timeIntervalSince1970: timeInterval)
    }
}
