import Ampere
import Foundation
import XCTest

class UnitMassTests: XCTestCase {

    func testWithBaseUnits() {
        let numerator = Measurement(value: 10, unit: UnitMass.grams)
        let denominator = Measurement(value: 2, unit: UnitVolume.liters)
        let actual = numerator / denominator
        let expected = Measurement(value: 5, unit: UnitConcentrationMass.gramsPerLiter)
        AmpereTest.assertEqual(actual, expected)
    }

    func testWithNonBaseUnits() {
        let numerator = Measurement(value: 100_000, unit: UnitMass.micrograms)
        let denominator = Measurement(value: 20, unit: UnitVolume.deciliters)
        let actual = numerator / denominator
        let expected = Measurement(value: 5, unit: UnitConcentrationMass.milligramsPerDeciliter)
        AmpereTest.assertEqual(actual, expected)
    }
    
    static var allTests : [(String, (UnitMassTests) -> () throws -> Void)] {
        return [
            ("testWithBaseUnits", testWithBaseUnits),
            ("testWithNonBaseUnits", testWithNonBaseUnits),
        ]
    }
}
