import Ampere
import XCTest

class UnitVolumeTests: XCTestCase {
    
    func testWithBaseUnits() {
        let factor1 = Measurement(value: 100, unit: UnitArea.squareMeters)
        let factor2 = Measurement(value: 10, unit: UnitLength.meters)
        let actual: Measurement<UnitVolume> = factor1 * factor2
        let expected = Measurement(value: 1000, unit: UnitVolume.cubicMeters)
        AmpereTest.assertEqual(actual, expected)
    }

    func testWithNonBaseUnits() {
        let factor1 = Measurement(value: 100, unit: UnitArea.squareCentimeters)
        let factor2 = Measurement(value: 10, unit: UnitLength.millimeters)
        let actual: Measurement<UnitVolume> = factor1 * factor2
        let expected = Measurement(value: 100, unit: UnitVolume.cubicCentimeters)
        AmpereTest.assertEqual(actual, expected)
    }

}
