import Ampere
import XCTest

/// Tests for the base functionality of `UnitProduct`.
///
/// - Multiplication and division operations.
/// - Correct mapping from between input units and result unit.
class UnitProductTests: XCTestCase {

    func testMultiplicationWithDefaultUnitMapping() {
        let speed = Measurement<SpeedDummy>(value: 10, unit: .metersPerSecond)
        let time = Measurement<DurationDummy>(value: 5, unit: .seconds)
        let length: Measurement<LengthDummy> = speed * time
        let expected = Measurement<LengthDummy>(value: 50, unit: .meters)
        AmpereTest.assertEqual(length, expected)
    }

    func testMultiplicationIsCommutative() {
        let speed = Measurement<SpeedDummy>(value: 10, unit: .metersPerSecond)
        let time = Measurement<DurationDummy>(value: 5, unit: .seconds)
        let length1: Measurement<LengthDummy> = speed * time
        let length2: Measurement<LengthDummy> = time * speed
        AmpereTest.assertEqual(length1, length2)
    }

    func testMultiplicationUsesPreferredUnitMapping() {
        let speed = Measurement<SpeedDummy>(value: 32, unit: .kilometersPerHour)
        let time = Measurement<DurationDummy>(value: 2, unit: .hours)
        let length: Measurement<LengthDummy> = speed * time
        let expected = Measurement<LengthDummy>(value: 64, unit: .kilometers)
        AmpereTest.assertEqualAndSameUnits(length, expected)
    }

    func testMultiplicationFallsBackToDefaultUnitMapping() {
        let speed = Measurement<SpeedDummy>(value: 32, unit: .kilometersPerHour)
        let time = Measurement<DurationDummy>(value: 3600, unit: .seconds)
        let length: Measurement<LengthDummy> = speed * time
        let expected = Measurement<LengthDummy>(value: 32, unit: .kilometers)
        AmpereTest.assertEqual(length, expected)
    }

    func testDivisionByFirstFactor() {
        let length = Measurement<LengthDummy>(value: 20, unit: .meters)
        let speed = Measurement<SpeedDummy>(value: 10, unit: .metersPerSecond)
        let time = length / speed
        let expected = Measurement<DurationDummy>(value: 2, unit: .seconds)
        AmpereTest.assertEqual(time, expected)
    }

    func testDivisionBySecondFactor() {
        let length = Measurement<LengthDummy>(value: 20, unit: .meters)
        let time = Measurement<DurationDummy>(value: 5, unit: .seconds)
        let speed = length / time
        let expected = Measurement<SpeedDummy>(value: 4, unit: .metersPerSecond)
        AmpereTest.assertEqual(speed, expected)
    }

    func testDivisionByFirstFactorUsesPreferredUnitMapping() {
        let length = Measurement<LengthDummy>(value: 500, unit: .kilometers)
        let speed = Measurement<SpeedDummy>(value: 125, unit: .kilometersPerHour)
        let time = length / speed
        let expected = Measurement<DurationDummy>(value: 4, unit: .hours)
        AmpereTest.assertEqualAndSameUnits(time, expected)
    }

    func testDivisionBySecondFactorUsesPreferredUnitMapping() {
        let length = Measurement<LengthDummy>(value: 20, unit: .kilometers)
        let time = Measurement<DurationDummy>(value: 5, unit: .hours)
        let speed = length / time
        let expected = Measurement<SpeedDummy>(value: 4, unit: .kilometersPerHour)
        AmpereTest.assertEqualAndSameUnits(speed, expected)
    }

    func testMultiplicationWithNonProportionalUnits() {
        let speed = Measurement<SpeedDummy>(value: 10, unit: .metersPerSecond)
        let time = Measurement<DurationDummy>(value: 1, unit: .hours)
        let length: Measurement<LengthDummy> = speed * time
        let expected = Measurement<LengthDummy>(value: 3_600_000, unit: .centimeters)
        AmpereTest.assertEqualAndSameUnits(length, expected)
    }

    func testDivisionByFirstFactorWithNonProportionalUnits() {
        let length = Measurement<LengthDummy>(value: 100_000, unit: .centimeters)
        let speed = Measurement<SpeedDummy>(value: 1, unit: .kilometersPerHour)
        let time = length / speed
        let expected = Measurement<DurationDummy>(value: 1, unit: .hours)
        AmpereTest.assertEqualAndSameUnits(time, expected)
    }

    func testDivisionBySecondFactorWithNonProportionalUnits() {
        let length = Measurement<LengthDummy>(value: 100_000, unit: .centimeters)
        let time = Measurement<DurationDummy>(value: 1, unit: .hours)
        let speed = length / time
        let expected = Measurement<SpeedDummy>(value: 1, unit: .kilometersPerHour)
        AmpereTest.assertEqualAndSameUnits(speed, expected)
    }

    static var allTests : [(String, (UnitProductTests) -> () throws -> Void)] {
        return [
            ("testMultiplicationWithDefaultUnitMapping", testMultiplicationWithDefaultUnitMapping),
            ("testMultiplicationIsCommutative", testMultiplicationIsCommutative),
            ("testMultiplicationUsesPreferredUnitMapping", testMultiplicationUsesPreferredUnitMapping),
            ("testMultiplicationFallsBackToDefaultUnitMapping", testMultiplicationFallsBackToDefaultUnitMapping),
            ("testDivisionByFirstFactor", testDivisionByFirstFactor),
            ("testDivisionBySecondFactor", testDivisionBySecondFactor),
            ("testDivisionByFirstFactorUsesPreferredUnitMapping", testDivisionByFirstFactorUsesPreferredUnitMapping),
            ("testDivisionBySecondFactorUsesPreferredUnitMapping", testDivisionBySecondFactorUsesPreferredUnitMapping),
            ("testMultiplicationWithNonProportionalUnits", testMultiplicationWithNonProportionalUnits),
            ("testDivisionByFirstFactorWithNonProportionalUnits", testDivisionByFirstFactorWithNonProportionalUnits),
            ("testDivisionBySecondFactorWithNonProportionalUnits", testDivisionBySecondFactorWithNonProportionalUnits),
        ]
    }
}


// MARK: - Dummy types that adopt `UnitProduct`.
// Define some dummy `Dimension` subclasses that adopt `UnitProduct` for the tests. This way we don’t mix the base functionality tests with the actual implementations of the protocol conformance for the "real" `Unit…` types.

class LengthDummy: Dimension {
    /// Base unit: meters
    override class func baseUnit() -> LengthDummy { return .meters }
    static let centimeters = LengthDummy(symbol: "cm", converter: UnitConverterLinear(coefficient: 0.01))
    static let meters = LengthDummy(symbol: "m", converter: UnitConverterLinear(coefficient: 1))
    static let kilometers = LengthDummy(symbol: "km", converter: UnitConverterLinear(coefficient: 1000))
}

class DurationDummy: Dimension {
    /// Base unit: seconds
    override class func baseUnit() -> DurationDummy { return .seconds }
    static let seconds = DurationDummy(symbol: "s", converter: UnitConverterLinear(coefficient: 1))
    static let hours = DurationDummy(symbol: "h", converter: UnitConverterLinear(coefficient: 3600))
}

class SpeedDummy: Dimension {
    /// Base unit: meters per second
    override class func baseUnit() -> SpeedDummy { return .metersPerSecond }
    static let metersPerSecond = SpeedDummy(symbol: "m/s", converter: UnitConverterLinear(coefficient: 1))
    static let kilometersPerHour = SpeedDummy(symbol: "km/h", converter: UnitConverterLinear(coefficient: 1.0/3.6))
}

// velocity = distance / time ⇔ distance = velocity * time
// Speed = Length / Duration ⇔ Length = Speed * Duration
extension LengthDummy: UnitProduct {
    typealias Factor1 = SpeedDummy
    typealias Factor2 = DurationDummy
    typealias Product = LengthDummy

    static func defaultUnitMapping() -> (Factor1, Factor2, Product) {
        return (.metersPerSecond, .seconds, .meters)
    }

    static func preferredUnitMappings() -> [(Factor1, Factor2, Product)] {
        return [
            (.kilometersPerHour, .hours, .kilometers),

            // "Non-proportional" unit mappings, i.e. 1 km/h * 1 h != 1 cm.
            // The computation must be performed in the default unit mapping and then converted to the desired unit mapping for this to be correct.
            (.kilometersPerHour, .hours, .centimeters),
            (.metersPerSecond, .hours, .centimeters),
        ]
    }
}
