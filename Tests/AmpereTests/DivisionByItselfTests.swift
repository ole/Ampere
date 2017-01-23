import Ampere
import XCTest

class DivisionByItselfTests: XCTestCase {

    func testDivisionByItselfWithTheSameUnit() {
        let width = Measurement(value: 4, unit: UnitLength.meters)
        let height = Measurement(value: 6, unit: UnitLength.meters)
        let ratio = height / width
        XCTAssertEqual(ratio, 1.5)
    }

    func testDivisionByItselfWithDifferentUnits() {
        let length = Measurement(value: 10, unit: UnitLength.miles)
        let subdivision = Measurement(value: 2, unit: UnitLength.feet)
        let ratio = length / subdivision
        XCTAssertEqualWithAccuracy(ratio, 26400, accuracy: 0.1)
    }

    static var allTests : [(String, (DivisionByItselfTests) -> () throws -> Void)] {
        return [
            ("testDivisionByItselfWithTheSameUnit", testDivisionByItselfWithTheSameUnit),
            ("testDivisionByItselfWithDifferentUnits", testDivisionByItselfWithDifferentUnits),
        ]
    }
}
