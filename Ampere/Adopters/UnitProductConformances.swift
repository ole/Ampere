import Foundation

/// Speed = Length / Duration ⇔ Length = Speed * Duration
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

    public static func defaultUnitMapping() -> (Factor1, Factor2, Product) {
        return (.squareMeters, .meters, .cubicMeters)
    }
}

/// Acceleration = Speed / Duration ⇔ Speed = Acceleration * Duration
extension UnitSpeed: UnitProduct {
    public typealias Factor1 = UnitAcceleration
    public typealias Factor2 = UnitDuration
    public typealias Product = UnitSpeed

    public static func defaultUnitMapping() -> (Factor1, Factor2, Product) {
        return (.metersPerSecondSquared, .seconds, .metersPerSecond)
    }
}

/// Density = Mass / Volume ⇔ Mass = Density * Volume
extension UnitMass: UnitProduct {
    public typealias Factor1 = UnitConcentrationMass
    public typealias Factor2 = UnitVolume
    public typealias Product = UnitMass

    public static func defaultUnitMapping() -> (Factor1, Factor2, Product) {
        return (.gramsPerLiter, .liters, .grams)
    }
}
