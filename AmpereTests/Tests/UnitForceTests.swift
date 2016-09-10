import Ampere
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
    
}
