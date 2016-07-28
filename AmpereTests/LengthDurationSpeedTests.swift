import Ampere
import XCTest

class LengthDurationSpeedTests: XCTestCase {
    
    func testMultiplicationInMetersPerSecond() {
        let speed = Measurement<UnitSpeed>(value: 10, unit: .metersPerSecond)
        let time = Measurement<UnitDuration>(value: 5, unit: .seconds)
        let length: Measurement<UnitLength> = speed * time
        let expected = Measurement<UnitLength>(value: 50, unit: .meters)
        AmpereTest.assertEqual(length, expected)
    }

    func testMultiplicationInKilometersPerHour() {
        let speed = Measurement<UnitSpeed>(value: 22, unit: .kilometersPerHour)
        let time = Measurement<UnitDuration>(value: 4.5, unit: .hours)
        let length: Measurement<UnitLength> = speed * time
        let expected = Measurement<UnitLength>(value: 99, unit: .kilometers)
        AmpereTest.assertEqual(length, expected, accuracy: epsilon)
    }

    func testMultiplicationInMilesPerHour() {
        let speed = Measurement<UnitSpeed>(value: 100, unit: .milesPerHour)
        let time = Measurement<UnitDuration>(value: 3.5, unit: .hours)
        let length: Measurement<UnitLength> = speed * time
        let expected = Measurement<UnitLength>(value: 350, unit: .miles)
        AmpereTest.assertEqual(length, expected, accuracy: epsilon)
    }

    func testMultiplicationInKnots() {
        let speed = Measurement<UnitSpeed>(value: 23, unit: .knots)
        let time = Measurement<UnitDuration>(value: 2, unit: .hours)
        let length: Measurement<UnitLength> = speed * time
        let expected = Measurement<UnitLength>(value: 46, unit: .nauticalMiles)
        AmpereTest.assertEqual(length, expected, accuracy: epsilon)
    }

    func testDivisionByDurationInMetersPerSecond() {
        let length = Measurement<UnitLength>(value: 100, unit: .meters)
        let time = Measurement<UnitDuration>(value: 10, unit: .seconds)
        let speed = length / time
        let expected = Measurement<UnitSpeed>(value: 10, unit: .metersPerSecond)
        AmpereTest.assertEqual(speed, expected)
    }

    func testDivisionByDurationInKilometersPerHour() {
        let length = Measurement<UnitLength>(value: 100, unit: .kilometers)
        let time = Measurement<UnitDuration>(value: 10, unit: .hours)
        let speed = length / time
        let expected = Measurement<UnitSpeed>(value: 10, unit: .kilometersPerHour)
        AmpereTest.assertEqual(speed, expected, accuracy: epsilon)
    }

    func testDivisionBySpeedInMetersPerSecond() {
        let length = Measurement<UnitLength>(value: 100, unit: .meters)
        let speed = Measurement<UnitSpeed>(value: 20, unit: .metersPerSecond)
        let time = length / speed
        let expected = Measurement<UnitDuration>(value: 5, unit: .seconds)
        AmpereTest.assertEqual(time, expected)
    }
}
