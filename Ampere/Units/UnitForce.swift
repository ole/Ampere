import Foundation

/// The unit of measure for force.
///
/// The base unit is `newtons`.
/// One newton is the force needed to accelerate one kilogram of mass at the rate of one metre per second squared in direction of the applied force.
/// (1 N = 1 kg * 1 m/s²)
public class UnitForce: Dimension {
    override public class func baseUnit() -> UnitForce {
        return .newtons
    }

    public static let newtons = UnitForce(symbol: "N", converter: UnitConverterLinear(coefficient: 1))
    public static let kiloNewtons = UnitForce(symbol: "kN", converter: UnitConverterLinear(coefficient: 1000))
    public static let kiloponds = UnitForce(symbol: "kp", converter: UnitConverterLinear(coefficient: 9.80665))
}

// Units should be equal if their symbols and converters are equal.
func ==(lhs: UnitForce, rhs: UnitForce) -> Bool {
    return lhs.symbol == rhs.symbol &&
        lhs.converter == rhs.converter
}
