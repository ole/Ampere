import Foundation

/// Length = Speed * Duration ⇔ Speed = Length / Duration
extension UnitLength: UnitProduct {
    public typealias Factor1 = UnitSpeed
    public typealias Factor2 = UnitDuration
    public typealias Product = UnitLength

    public static func defaultUnitMapping() -> (Factor1, Factor2, Product) {
        return (.metersPerSecond, .seconds, .meters)
    }

    public static func preferredUnitMappings() -> [(Factor1, Factor2, Product)] {
        return [
            (.kilometersPerHour, .hours, .kilometers),
            (.milesPerHour, .hours, .miles),
            (.knots, .hours, .nauticalMiles)
        ]
    }
}

/// Volume = Area * Length
extension UnitVolume: UnitProduct {
    public typealias Factor1 = UnitArea
    public typealias Factor2 = UnitLength
    public typealias Product = UnitVolume

    public static func defaultUnitMapping() -> (UnitArea, UnitLength, UnitVolume) {
        return (.squareMeters, .meters, .cubicMeters)
    }
}
