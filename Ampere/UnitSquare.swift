import Foundation

public protocol UnitSquare {
    associatedtype Factor: Dimension
    associatedtype Product: Dimension

    static func defaultUnitMapping() -> (Factor, Factor, Product)
    static func preferredUnitMappings() -> [(Factor, Factor, Product)]
}

extension UnitSquare {
    public static func preferredUnitMappings() -> [(Factor, Factor, Product)] {
        return []
    }
}

extension UnitSquare {
    public static func unitMapping(factor1: Factor, factor2: Factor) -> (Factor, Factor, Product) {
        let match = preferredUnitMappings().first { (f1, f2, _) in
            f1 === factor1 && f2 === factor2
        }
        return match ?? defaultUnitMapping()
    }

    public static func unitMapping(product: Product, factor: Factor) -> (Factor, Factor, Product) {
        let match1 = preferredUnitMappings().first { (f1, _, p) in
            f1 == factor && p === product
        }
        let match2 = preferredUnitMappings().first { (_, f2, p) in
            f2 == factor && p === product
        }
        return match1 ?? match2 ?? defaultUnitMapping()
    }
}

/// UnitSquare.Product = Factor * Factor
public func * <UnitType: Dimension where UnitType: UnitSquare, UnitType == UnitType.Product> (lhs: Measurement<UnitType.Factor>, rhs: Measurement<UnitType.Factor>) -> Measurement<UnitType> {
    // Perform the calculation in the default unit mapping
    let (leftUnit, rightUnit, resultUnit) = UnitType.defaultUnitMapping()
    let value = lhs.converted(to: leftUnit).value * rhs.converted(to: rightUnit).value
    let result = Measurement(value: value, unit: resultUnit)

    // Convert to preferred unit mapping
    let (_, _, preferredUnit) = UnitType.unitMapping(factor1: lhs.unit, factor2: rhs.unit)
    return result.converted(to: preferredUnit)
}

/// UnitProduct / Factor = Factor
public func / <UnitType: Dimension where UnitType: UnitSquare, UnitType == UnitType.Product> (lhs: Measurement<UnitType.Product>, rhs: Measurement<UnitType.Factor>) -> Measurement<UnitType.Factor> {
    let (resultUnit, rightUnit, leftUnit) = UnitType.defaultUnitMapping()
    let value = lhs.converted(to: leftUnit).value / rhs.converted(to: rightUnit).value
    let result = Measurement(value: value, unit: resultUnit)

    // Convert to preferred unit mapping
    let (preferredUnit, _, _) = UnitType.unitMapping(product: lhs.unit, factor: rhs.unit)
    return result.converted(to: preferredUnit)
}
