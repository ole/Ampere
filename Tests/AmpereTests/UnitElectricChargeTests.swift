import Ampere
import XCTest

class UnitElectricChargeTests: XCTestCase {

    func testWithBaseUnits() {
        let factor1 = Measurement(value: 100, unit: UnitElectricCurrent.amperes)
        let factor2 = Measurement(value: 10, unit: UnitDuration.seconds)
        let actual: Measurement<UnitElectricCharge> = factor1 * factor2
        let expected = Measurement(value: 1000, unit: UnitElectricCharge.coulombs)
        AmpereTest.assertEqual(actual, expected)
    }

    func testWithNonBaseUnits() {
        let factor1 = Measurement(value: 20, unit: UnitElectricCurrent.milliamperes)
        let factor2 = Measurement(value: 3, unit: UnitDuration.hours)
        let actual: Measurement<UnitElectricCharge> = factor1 * factor2
        let expected = Measurement(value: 60, unit: UnitElectricCharge.milliampereHours)
        AmpereTest.assertEqual(actual, expected)
    }
    
    static var allTests : [(String, (UnitElectricChargeTests) -> () throws -> Void)] {
        return [
            ("testWithBaseUnits", testWithBaseUnits),
            ("testWithNonBaseUnits", testWithNonBaseUnits),
        ]
    }
}
