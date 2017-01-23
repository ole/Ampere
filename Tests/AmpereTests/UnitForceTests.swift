import Ampere
import Foundation
import XCTest

class UnitForceTests: XCTestCase {
    
    func testBaseUnitIsNewtons() {
        let baseUnit = UnitForce.baseUnit()
        XCTAssertEqual(baseUnit.symbol, "N")
        XCTAssertEqual(baseUnit, UnitForce.newtons)
    }

    func testUnitsWithSameSymbolAndConverterAreEqual() {
        let newInstance = UnitForce(symbol: "N", converter: UnitConverterLinear(coefficient: 1))
        XCTAssertEqual(newInstance, UnitForce.newtons)
    }

    func testKiloNewtons() {
        let kilonewtons = Measurement(value: 10, unit: UnitForce.kiloNewtons)
        let expected = Measurement(value: 10_000, unit: UnitForce.newtons)
        XCTAssertEqual(kilonewtons, expected)
    }

    func testKiloponds() {
        let kiloponds = Measurement(value: 1000, unit: UnitForce.kiloponds)
        let expected = Measurement(value: 9806.65, unit: UnitForce.newtons)
        XCTAssertEqual(kiloponds, expected)
    }

    func testWithBaseUnits() {
        let factor1 = Measurement(value: 100, unit: UnitMass.kilograms)
        let factor2 = Measurement(value: 10, unit: UnitAcceleration.metersPerSecondSquared)
        let actual: Measurement<UnitForce> = factor1 * factor2
        let expected = Measurement(value: 1000, unit: UnitForce.newtons)
        AmpereTest.assertEqual(actual, expected)
    }

    func testWithNonBaseUnits() {
        let factor1 = Measurement(value: 100, unit: UnitMass.metricTons)
        let factor2 = Measurement(value: 1, unit: UnitAcceleration.gravity)
        let actual: Measurement<UnitForce> = factor1 * factor2
        let expected = Measurement(value: 981, unit: UnitForce.kiloNewtons)
        AmpereTest.assertEqual(actual, expected)
    }

    static var allTests : [(String, (UnitForceTests) -> () throws -> Void)] {
        return [
            ("testBaseUnitIsNewtons", testBaseUnitIsNewtons),
            ("testUnitsWithSameSymbolAndConverterAreEqual", testUnitsWithSameSymbolAndConverterAreEqual),
            ("testKiloNewtons", testKiloNewtons),
            ("testKiloponds", testKiloponds),
            ("testWithBaseUnits", testWithBaseUnits),
            ("testWithNonBaseUnits", testWithNonBaseUnits),
        ]
    }
}
