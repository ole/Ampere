import XCTest

/// Namespace
enum AmpereTest {
    /// Custom variant of `XCTAssertEqual` for values of type `Measurement`.
    ///
    /// We need this because `XCTAssertEqual` exhibits some strange behavior with arguments of type `Measurement` when the two arguments have different units (but should be equal). Tested in Xcode 8 beta 3. Example:
    ///
    ///     let a = Measurement(value: 1, unit: UnitLength.kilometers)
    ///     let b = Measurement(value: 1000, unit: UnitLength.meters)
    ///     a == b // true
    ///     XCTAssertEqual(a, b) // fails even though a == b!
    ///
    /// This function converts both arguments to the same unit before performing the comparison as a workaround. It should be deleted when the issue is fixed in XCTest.
    ///
    /// - Seealso: http://www.openradar.me/27556581
    static func assertEqual<T: Dimension>(_ expression1: @autoclosure () throws -> Measurement<T>, _ expression2: @autoclosure () throws -> Measurement<T>, _ message: @autoclosure () -> String = "", file: StaticString = #file, line: UInt = #line) {
        do {
            let e1 = try expression1()
            let e2 = try expression2()
            let errorMessage = [message(), "\"\(e1)\" is not equal to \"\(e2)\""].joined(separator: " – ", ignoreEmptyStrings: true)
            XCTAssertEqual(e1, e2.converted(to: e1.unit), errorMessage, file: file, line: line)
        } catch {
            XCTFail("AmpereAssertEqual threw an error: \(error)")
        }
    }

    /// Custom variant of `XCTAssertEqual` for values of type `Measurement`.
    /// Asserts that both arguments are not only equal in value, but they also have the same unit.
    /// For example, the assertion fails for `a = 1 km and b = 1000 m`. The assertion passes for `a = 1 km and b = 1 km`.
    static func assertEqualAndSameUnits<T: Dimension>(_ expression1: @autoclosure () throws -> Measurement<T>, _ expression2: @autoclosure () throws -> Measurement<T>, _ message: @autoclosure () -> String = "", file: StaticString = #file, line: UInt = #line) {
        do {
            let e1 = try expression1()
            let e2 = try expression2()
            let messageIfValuesNotEqual = [message(), "\"\(e1)\" is not equal to \"\(e2)\""].joined(separator: " – ", ignoreEmptyStrings: true)
            let messageIfUnitsNotEqual = [message(), "\"\(e1.unit.symbol)\" is not the same unit as \"\(e2.unit.symbol)\""].joined(separator: " – ", ignoreEmptyStrings: true)
            XCTAssertEqual(e1, e2.converted(to: e1.unit), messageIfValuesNotEqual, file: file, line: line)
            XCTAssertTrue(e1.unit === e2.unit, messageIfUnitsNotEqual, file: file, line: line)
        } catch {
            XCTFail("AmpereAssertEqualAndSameUnit threw an error: \(error)")
        }
    }
}
