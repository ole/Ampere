import Ampere
import XCTest

class UnitElectricPotentialDifferenceTests: XCTestCase {

    func testWithBaseUnits() {
        let numerator = Measurement(value: 10, unit: UnitElectricPotentialDifference.volts)
        let denominator = Measurement(value: 2, unit: UnitElectricCurrent.amperes)
        let actual = numerator / denominator
        let expected = Measurement(value: 5, unit: UnitElectricResistance.ohms)
        AmpereTest.assertEqual(actual, expected)
    }

    func testWithNonBaseUnits() {
        let numerator = Measurement(value: 100, unit: UnitElectricPotentialDifference.kilovolts)
        let denominator = Measurement(value: 10, unit: UnitElectricCurrent.kiloamperes)
        let actual = numerator / denominator
        let expected = Measurement(value: 10, unit: UnitElectricResistance.ohms)
        AmpereTest.assertEqual(actual, expected, accuracy: epsilon)
    }
    
}
