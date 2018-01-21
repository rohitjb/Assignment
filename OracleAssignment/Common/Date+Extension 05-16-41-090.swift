import Foundation

extension Date {
    struct Formatter {
        private static let locale = Locale(identifier: "en_GB")

        private static let timeZone: TimeZone = {
            guard let timeZone = TimeZone(identifier: "Europe/London") else {
                preconditionFailure()
            }
            return timeZone
        }()

        fileprivate static let calendar: Calendar = {
            var calendar = locale.calendar
            calendar.timeZone = timeZone
            return calendar
        }()

        static let iso8601: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXXXX"
            formatter.timeZone = timeZone
            formatter.calendar = calendar
            formatter.locale = locale
            return formatter
        }()

        fileprivate static let partialSunDisplay: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMMM yyyy, hh:mm a"
            formatter.amSymbol = "am"
            formatter.pmSymbol = "pm"
            formatter.timeZone = timeZone
            formatter.calendar = calendar
            formatter.locale = locale
            return formatter
        }()

        fileprivate static let sunTop10Display: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEEE dd MMMM"
            formatter.timeZone = timeZone
            formatter.calendar = calendar
            formatter.locale = locale
            return formatter
        }()

        fileprivate static let sunTop10AnalyticsPayload: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd HH:mm EEEE"
            formatter.timeZone = timeZone
            formatter.calendar = calendar
            formatter.locale = locale
            return formatter
        }()
    }

    var stringFromISO8601: String {
        return Formatter.iso8601.string(from: self)
    }

    public var stringFromSunFormat: String {
        let dayOfTheMonth = Formatter.calendar.component(.day, from: self)
        return "\(dayOfTheMonth.asOrdinal()) \(Formatter.partialSunDisplay.string(from: self))"
    }

    public var stringFromSunTop10Format: String {
        return (Formatter.sunTop10Display.string(from: self))
    }

    public var stringFromSunTop10AnalyticsFormat: String {
        return (Formatter.sunTop10AnalyticsPayload.string(from: self))
    }
    
    func toDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: self)
    }
    
    func toUrl() -> URL? {
        let urlString = APIParamConstants.baseURL + "?published_date=\(self.toDateString())&api-key=\(APIParamConstants.key)"
        let url = URL(string: urlString)
        return url
    }
}

private extension Int {
    func asOrdinal() -> String {
        let absoluteValue = abs(self)

        if (11...13).contains(self) {
            return "\(self)th"
        }

        switch absoluteValue % 10 {
        case 1:
            return "\(self)st"
        case 2:
            return "\(self)nd"
        case 3:
            return "\(self)rd"
        default:
            return "\(self)th"
        }
    }
}
