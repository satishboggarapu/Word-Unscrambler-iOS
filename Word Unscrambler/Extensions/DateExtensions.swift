import Foundation

extension Date {
    func addDays(_ numDays: Int) -> Date {
        var components = DateComponents()
        components.day = numDays

        return Calendar.current.date(byAdding: components, to: self)!
    }

    func daysAgo(_ numDays: Int) -> Date {
        addDays(-numDays)
    }
}
