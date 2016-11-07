
import Foundation

extension NSDate {
    private class func minuteInSeconds() -> Double { return 60 }
    private class func hourInSeconds() -> Double { return 3600 }
    private class func dayInSeconds() -> Double { return 86400 }
    private class func weekInSeconds() -> Double { return 604800 }
    private class func monthInSeconds() -> Double { return 2592000 }
    private class func yearInSeconds() -> Double { return 31556926 }

    class func stringToDate(stringDate: String, dateFormat: String) -> NSDate {
        let dateFormater = NSDateFormatter()
        dateFormater.dateFormat = dateFormat
        dateFormater.timeZone = NSTimeZone(name: "GMT")
        return dateFormater.dateFromString(stringDate)!
    }

    class func dateToString(date: NSDate, dateFormat: String) -> String {
        let dateFormater = NSDateFormatter()
        dateFormater.dateFormat = dateFormat
        return dateFormater.stringFromDate(date)
    }

    func dateToString(dateFormat: String) -> String {
        let dateFormater = NSDateFormatter()
        dateFormater.dateFormat = dateFormat
        return dateFormater.stringFromDate(self)
    }

    func toDateAgo() -> String {
        let deltaYear = yearsBeforeDate(NSDate())
        if deltaYear == 0 {
            return processingMonthComponent()
        } else if deltaYear == 1 {
            return NSLocalizedString("construction_activity_one_year", comment: "One year ago")
        }
        return NSLocalizedString("construction_activity_more_than_year", comment: "More than a year ago")
    }

    private func processingMonthComponent() -> String {
        let deltaMonth = monthsBeforeDate(NSDate())
        if deltaMonth == 0 {
            return processingWeekComponent()
        } else if deltaMonth == 1 {
            return NSLocalizedString("construction_activity_one_month", comment: "A month ago")
        }

        // --Old
        // return "\(deltaMonth) months ago"
        //
        // --New changed specs
        //

        if deltaMonth == 11 || deltaMonth == 12 {
            return NSLocalizedString("construction_activity_one_year", comment: "One year ago") // 12 months
        }

        if deltaMonth % 2 == 0 {
            return String(format: NSLocalizedString("construction_activity_two_months", comment: "months"), String(deltaMonth))
        } else {
            return String(format: NSLocalizedString("construction_activity_two_months", comment: "months"), String(deltaMonth + 1))
        }
    }

    private func processingWeekComponent() -> String {
        let deltaWeek = weeksBeforeDate(NSDate())
        if deltaWeek == 0 {
            return processingDateComponent()
        } else if deltaWeek == 1 {
            return NSLocalizedString("construction_activity_one_week", comment: "A week ago")
        }
        return String(format: NSLocalizedString("construction_activity_two_weeks", comment: "weeks"), String(deltaWeek))
    }

    private func processingDateComponent() -> String {
        let deltaDate = daysBeforeDate(NSDate())
        if deltaDate == 0 {
            return processingHourComponent()
        } else if deltaDate == 1 {
            return NSLocalizedString("construction_activity_between_one_and_two_days", comment: "A day ago")
        }
        return String(format: NSLocalizedString("construction_activity_between_two_and_three_days", comment: "days"), String(deltaDate))
    }

    private func processingHourComponent() -> String {
        let deltaHour = hoursBeforeDate(NSDate())
        if deltaHour == 0 {
            return processingMinuteComponent()
        } else if deltaHour == 1 {
            return NSLocalizedString("construction_activity_between_60_and_120_minutes", comment: "An hour ago")
        }

        return String(format: NSLocalizedString("construction_activity_between_120_and_180_minutes", comment: "hour"), String(deltaHour))
    }

    private func processingMinuteComponent() -> String {
        let deltaMin = minutesBeforeDate(NSDate())
        if deltaMin == 0 {
            return NSLocalizedString("construction_activity_less_than_one_minute", comment: "There is less than a minute")
        } else if deltaMin == 1 {
            return NSLocalizedString("construction_activity_between_one_and_two_minutes", comment: "There is one minute")
        }
        return String(format: NSLocalizedString("construction_activity_between_two_and_three_minutes", comment: "mins"), String(deltaMin))
    }

    private func processingSecondComponent() -> String {
        let deltaSec = secondsBeforeDate(NSDate())
        if deltaSec < 60 {
            return NSLocalizedString("construction_activity_less_than_one_minute", comment: "There is less than a minute")

        } else {
            return NSLocalizedString("construction_activity_between_one_and_two_minutes", comment: "There is one minute")
        }
    }

    func getDayOfWeek() -> Int {
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        let components = calendar!.components([.Weekday], fromDate: self)

        return components.weekday
    }
}

extension NSDate {
    func secondsBeforeDate(date: NSDate) -> Int {
        return Int(date.timeIntervalSinceDate(self))
    }

    func minutesBeforeDate(date: NSDate) -> Int {
        let interval = date.timeIntervalSinceDate(self)
        return Int(interval / NSDate.minuteInSeconds())
    }

    func hoursBeforeDate(date: NSDate) -> Int {
        let interval = date.timeIntervalSinceDate(self)
        return Int(interval / NSDate.hourInSeconds())
    }

    func daysBeforeDate(date: NSDate) -> Int {
        let interval = date.timeIntervalSinceDate(self)
        return Int(interval / NSDate.dayInSeconds())
    }
    func weeksBeforeDate(date: NSDate) -> Int {
        let interval = date.timeIntervalSinceDate(self)
        return Int(interval / NSDate.weekInSeconds())
    }

    func monthsBeforeDate(date: NSDate) -> Int {
        let interval = date.timeIntervalSinceDate(self)
        return Int(interval / 2592000)
    }

    func yearsBeforeDate(date: NSDate) -> Int {
        let interval = date.timeIntervalSinceDate(self)
        return Int(interval / 31556926)
    }
}
