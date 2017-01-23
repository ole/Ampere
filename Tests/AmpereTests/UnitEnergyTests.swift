import Ampere
import Foundation
import XCTest

class UnitEnergyTests: XCTestCase {

    func testWithBaseUnits() {
        let factor1 = Measurement(value: 100, unit: UnitPower.watts)
        let factor2 = Measurement(value: 10, unit: UnitDuration.seconds)
        let actual: Measurement<UnitEnergy> = factor1 * factor2
        let expected = Measurement(value: 1000, unit: UnitEnergy.joules)
        AmpereTest.assertEqual(actual, expected)
    }

    func testWithNonBaseUnits() {
        let factor1 = Measurement(value: 20, unit: UnitPower.kilowatts)
        let factor2 = Measurement(value: 3, unit: UnitDuration.hours)
        let actual: Measurement<UnitEnergy> = factor1 * factor2
        let expected = Measurement(value: 60, unit: UnitEnergy.kilowattHours)
        AmpereTest.assertEqual(actual, expected)
    }
    
    static var allTests : [(String, (UnitEnergyTests) -> () throws -> Void)] {
        return [
            ("testWithBaseUnits", testWithBaseUnits),
            ("testWithNonBaseUnits", testWithNonBaseUnits),
        ]
    }
}
