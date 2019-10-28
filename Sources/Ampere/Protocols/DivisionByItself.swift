import Foundation

/// Dividing a physical quantity by the same quantity returns a dimensionless quantity.
public func / <UnitType: Dimension> (lhs: Measurement<UnitType>, rhs: Measurement<UnitType>) -> Double {
    return lhs.converted(to: UnitType.baseUnit()).value / rhs.converted(to: UnitType.baseUnit()).value
}
