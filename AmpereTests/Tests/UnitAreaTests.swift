import Ampere
import XCTest

class UnitAreaTests: XCTestCase {
    func testMultiplicationWithDefaultUnits() {
        let width = Measurement(value: 4, unit: UnitLength.meters)
        let height = Measurement(value: 6, unit: UnitLength.meters)
        let area: Measurement<UnitArea> = width * height
        let expected = Measurement(value: 24, unit: UnitArea.squareMeters)
        AmpereTest.assertEqualAndSameUnits(area, expected)
    }

    func testDivisionWithDefaultUnits() {
        let area = Measurement(value: 100, unit: UnitArea.squareMeters)
        let width = Measurement(value: 5, unit: UnitLength.meters)
        let height = area / width
        let expected = Measurement(value: 20, unit: UnitLength.meters)
        AmpereTest.assertEqualAndSameUnits(height, expected)
    }

    func testMultiplicationWithNonDefaultUnits() {
        let width = Measurement(value: 100, unit: UnitLength.kilometers)
        let height = Measurement(value: 10, unit: UnitLength.centimeters)
        let area: Measurement<UnitArea> = width * height
        let expected = Measurement(value: 10000, unit: UnitArea.squareMeters)
        AmpereTest.assertEqualAndSameUnits(area, expected)
    }

    func testDivisionWithNonDefaultUnits() {
        let area = Measurement(value: 10, unit: UnitArea.squareMiles)
        let width = Measurement(value: 5, unit: UnitLength.miles)
        let height = area / width
        let expected = Measurement(value: 2, unit: UnitLength.miles)
        AmpereTest.assertEqual(height, expected, accuracy: 0.1)
    }

}
