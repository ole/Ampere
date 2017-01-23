import Ampere
import Foundation
import XCTest

class UnitSpeedTests: XCTestCase {

    func testWithBaseUnits() {
        let numerator = Measurement(value: 10, unit: UnitSpeed.metersPerSecond)
        let denominator = Measurement(value: 2, unit: UnitDuration.seconds)
        let actual = numerator / denominator
        let expected = Measurement(value: 5, unit: UnitAcceleration.metersPerSecondSquared)
        AmpereTest.assertEqual(actual, expected)
    }

    func testWithNonBaseUnits() {
        let numerator = Measurement(value: 36, unit: UnitSpeed.kilometersPerHour)
        let denominator = Measurement(value: 1, unit: UnitDuration.minutes)
        let actual = numerator / denominator
        let expected = Measurement(value: 0.16666667, unit: UnitAcceleration.metersPerSecondSquared)
        AmpereTest.assertEqual(actual, expected, accuracy: epsilon)
    }
    
    static var allTests : [(String, (UnitSpeedTests) -> () throws -> Void)] {
        return [
            ("testWithBaseUnits", testWithBaseUnits),
            ("testWithNonBaseUnits", testWithNonBaseUnits),
        ]
    }
}
