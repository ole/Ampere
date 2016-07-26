import Foundation

public protocol UnitProduct {
    associatedtype Factor1: Dimension
    associatedtype Factor2: Dimension
    associatedtype Product: Dimension

    static func defaultUnitMapping() -> (Factor1, Factor2, Product)
    static func unitMappings() -> [(Factor1, Factor2, Product)]
}

extension UnitProduct {
    // Default implementation. Implement this method in conforming types to specify additional preferred unit mappings.
    public static func unitMappings() -> [(Factor1, Factor2, Product)] {
        return []
    }
}

extension UnitProduct {
    // Based on the assumption that each unit has unique object identity. Otherwise this will fail.
    public static func unitMapping(factor1: Factor1, factor2: Factor2) -> (Factor1, Factor2, Product) {
        return unitMappings().first(where: { (f1, f2, _) in f1 === factor1 && f2 === factor2 }) ?? defaultUnitMapping()
    }

    public static func reverseUnitMapping(product: Product, factor2: Factor2) -> (Factor1, Factor2, Product) {
        return unitMappings().first(where: { (_, f2, p) in p === product && f2 === factor2 }) ?? defaultUnitMapping()
    }

    public static func reverseUnitMapping(product: Product, factor1: Factor1) -> (Factor1, Factor2, Product) {
        return unitMappings().first(where: { (f1, _, p) in p === product && f1 === factor1 }) ?? defaultUnitMapping()
    }
}

public func * <UnitType: Dimension where UnitType: UnitProduct, UnitType == UnitType.Product> (lhs: Measurement<UnitType.Factor1>, rhs: Measurement<UnitType.Factor2>) -> Measurement<UnitType.Product> {
    let (leftUnit, rightUnit, resultUnit) = UnitType.unitMapping(factor1: lhs.unit, factor2: rhs.unit)
    let value = lhs.converted(to: leftUnit).value * rhs.converted(to: rightUnit).value
    return Measurement(value: value, unit: resultUnit)
}

/// This would be better with a constraint like UnitType.Factor1 != UnitType.Factor2, but that doesn’t seem to be possible.
/// Leads to "ambiguous use of operator *" for UnitArea.
public func * <UnitType: Dimension where UnitType: UnitProduct, UnitType == UnitType.Product> (lhs: Measurement<UnitType.Factor2>, rhs: Measurement<UnitType.Factor1>) -> Measurement<UnitType.Product> {
    return rhs * lhs
}

public func / <UnitType: Dimension where UnitType: UnitProduct, UnitType == UnitType.Product> (lhs: Measurement<UnitType.Product>, rhs: Measurement<UnitType.Factor2>) -> Measurement<UnitType.Factor1> {
    let (resultUnit, rightUnit, leftUnit) = UnitType.reverseUnitMapping(product: lhs.unit, factor2: rhs.unit)
    let value = lhs.converted(to: leftUnit).value / rhs.converted(to: rightUnit).value
    return Measurement(value: value, unit: resultUnit)
}

/// Same here: "ambiguous use of operator '/'"
public func / <UnitType: Dimension where UnitType: UnitProduct, UnitType == UnitType.Product> (lhs: Measurement<UnitType.Product>, rhs: Measurement<UnitType.Factor1>) -> Measurement<UnitType.Factor2> {
    let (rightUnit, resultUnit, leftUnit) = UnitType.reverseUnitMapping(product: lhs.unit, factor1: rhs.unit)
    let value = lhs.converted(to: leftUnit).value / rhs.converted(to: rightUnit).value
    return Measurement(value: value, unit: resultUnit)
}
