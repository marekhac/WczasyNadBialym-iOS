//
//  DateFormatter+CustomFormats.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 31.07.2017.
//  Copyright © 2017 Marek Hać. All rights reserved.
//

import Foundation

struct DateParameters {
    static let TimeZoneUTC = "UTC"
    static let Date = "dd.MM.yyyy"
    static let DateAndTime = "dd.MM.yyyy HH:mm"
    static let HourAndMinutes = "HH:mm"
}

extension DateFormatter {
    
    convenience init(dateFormat: String) {
        self.init()
        self.dateFormat =  dateFormat
        self.timeZone = TimeZone(abbreviation: DateParameters.TimeZoneUTC)
    }
}

extension Date {
    struct Formatter {
        static let customDateAndHourFormat = DateFormatter(dateFormat: DateParameters.DateAndTime)
    }
    var customFormatted: String {
        return Formatter.customDateAndHourFormat.string(from: self)
    }
    
    public func getHourAndMinutes() -> String {
        let formatter = DateFormatter(dateFormat: DateParameters.HourAndMinutes)
        return formatter.string(from: self)
    }

    public func getDate() -> String {
        let formatter = DateFormatter(dateFormat: DateParameters.Date)
        return formatter.string(from: self)
    }
}
