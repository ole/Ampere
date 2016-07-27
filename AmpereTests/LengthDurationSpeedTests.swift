import Ampere
import XCTest

class LengthDurationSpeedTests: XCTestCase {
    
    func testMultiplicationInMetersPerSecond() {
        let speed = Measurement<UnitSpeed>(value: 10, unit: .metersPerSecond)
        let time = Measurement<UnitDuration>(value: 5, unit: .seconds)
        let length: Measurement<UnitLength> = speed * time
        let expected = Measurement<UnitLength>(value: 50, unit: .meters)
        XCTAssertTrue(length == expected)
        XCTAssertTrue(length.unit == expected.unit)
    }

    func testMultiplicationInKilometersPerHour() {
        let speed = Measurement<UnitSpeed>(value: 22, unit: .kilometersPerHour)
        let time = Measurement<UnitDuration>(value: 4.5, unit: .hours)
        let length: Measurement<UnitLength> = speed * time
        let expected = Measurement<UnitLength>(value: 99, unit: .kilometers)
        XCTAssertTrue(length == expected)
        XCTAssertTrue(length.unit == expected.unit)
    }

    func testMultiplicationInMilesPerHour() {
        let speed = Measurement<UnitSpeed>(value: 100, unit: .milesPerHour)
        let time = Measurement<UnitDuration>(value: 3.5, unit: .hours)
        let length: Measurement<UnitLength> = speed * time
        let expected = Measurement<UnitLength>(value: 350, unit: .miles)
        XCTAssertTrue(length == expected)
        XCTAssertTrue(length.unit == expected.unit)
    }

    func testMultiplicationInKnots() {
        let speed = Measurement<UnitSpeed>(value: 23, unit: .knots)
        let time = Measurement<UnitDuration>(value: 2, unit: .hours)
        let length: Measurement<UnitLength> = speed * time
        let expected = Measurement<UnitLength>(value: 46, unit: .nauticalMiles)
        XCTAssertTrue(length == expected)
        XCTAssertTrue(length.unit == expected.unit)
    }

    func testDivisionByDurationInMetersPerSecond() {
        let length = Measurement<UnitLength>(value: 100, unit: .meters)
        let time = Measurement<UnitDuration>(value: 10, unit: .seconds)
        let speed = length / time
        let expected = Measurement<UnitSpeed>(value: 10, unit: .metersPerSecond)
        XCTAssertTrue(speed == expected)
        XCTAssertTrue(speed.unit == expected.unit)
    }

    func testDivisionByDurationInKilometersPerHour() {
        let length = Measurement<UnitLength>(value: 100, unit: .kilometers)
        let time = Measurement<UnitDuration>(value: 10, unit: .hours)
        let speed = length / time
        let expected = Measurement<UnitSpeed>(value: 10, unit: .kilometersPerHour)
        XCTAssertTrue(speed == expected)
        XCTAssertTrue(speed.unit == expected.unit)
    }

    func testDivisionBySpeedInMetersPerSecond() {
        let length = Measurement<UnitLength>(value: 100, unit: .meters)
        let speed = Measurement<UnitSpeed>(value: 20, unit: .metersPerSecond)
        let time = length / speed
        let expected = Measurement<UnitDuration>(value: 5, unit: .seconds)
        XCTAssertTrue(time == expected)
        XCTAssertTrue(time.unit == expected.unit)
    }
}
