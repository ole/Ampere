import Foundation

/// Speed = Length / Duration ⇔ Length = Speed * Duration
/// 1 m/s = 1 m / 1 s
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
/// 1 m³ = 1 m² * 1 m
extension UnitVolume: UnitProduct {
    public typealias Factor1 = UnitArea
    public typealias Factor2 = UnitLength
    public typealias Product = UnitVolume

    public static func defaultUnitMapping() -> (Factor1, Factor2, Product) {
        return (.squareMeters, .meters, .cubicMeters)
    }
}

/// Acceleration = Speed / Duration ⇔ Speed = Acceleration * Duration
/// 1 m/s² = 1 m/s / 1 s
extension UnitSpeed: UnitProduct {
    public typealias Factor1 = UnitAcceleration
    public typealias Factor2 = UnitDuration
    public typealias Product = UnitSpeed

    public static func defaultUnitMapping() -> (Factor1, Factor2, Product) {
        return (.metersPerSecondSquared, .seconds, .metersPerSecond)
    }
}

/// Density = Mass / Volume ⇔ Mass = Density * Volume
/// 1 kg/m³ = 1 kg / 1 m³
extension UnitMass: UnitProduct {
    public typealias Factor1 = UnitConcentrationMass
    public typealias Factor2 = UnitVolume
    public typealias Product = UnitMass

    public static func defaultUnitMapping() -> (Factor1, Factor2, Product) {
        return (.gramsPerLiter, .liters, .grams)
    }
}

/// Resistance = Voltage / Current ⇔ Voltage = Resistance * Current
/// 1 Ω = 1 V / 1 A
extension UnitElectricPotentialDifference: UnitProduct {
    public typealias Factor1 = UnitElectricResistance
    public typealias Factor2 = UnitElectricCurrent
    public typealias Product = UnitElectricPotentialDifference

    public static func defaultUnitMapping() -> (Factor1, Factor2, Product) {
        return (.ohms, .amperes, .volts)
    }
}

/// Energy = Power * Duration
/// 1 J = 1 W * 1 s
extension UnitEnergy: UnitProduct {
    public typealias Factor1 = UnitPower
    public typealias Factor2 = UnitDuration
    public typealias Product = UnitEnergy

    public static func defaultUnitMapping() -> (Factor1, Factor2, Product) {
        return (.watts, .seconds, .joules)
    }
}

/// Charge = Current * Duration
/// 1 C = 1 A * 1 s
extension UnitElectricCharge: UnitProduct {
    public typealias Factor1 = UnitElectricCurrent
    public typealias Factor2 = UnitDuration
    public typealias Product = UnitElectricCharge

    public static func defaultUnitMapping() -> (Factor1, Factor2, Product) {
        return (.amperes, .seconds, .coulombs)
    }
}
