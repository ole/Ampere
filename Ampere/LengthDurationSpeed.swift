import Foundation

/// Length = Speed * Duration ⇔ Speed = Length / Duration
extension UnitLength: UnitProduct {
    public typealias Factor1 = UnitSpeed
    public typealias Factor2 = UnitDuration
    public typealias Product = UnitLength

    public static func defaultUnitMapping() -> (Factor1, Factor2, Product) {
        return (.metersPerSecond, .seconds, .meters)
    }

    public static func unitMappings() -> [(Factor1, Factor2, Product)] {
        return [
            (.kilometersPerHour, .hours, .kilometers),
            (.milesPerHour, .hours, .miles),
            (.knots, .hours, .nauticalMiles)
        ]
    }
}
