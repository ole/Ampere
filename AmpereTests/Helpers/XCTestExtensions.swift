import XCTest

/// Namespace
enum AmpereTest {
    /// Custom variant of `XCTAssertEqual` for values of type `Measurement`.
    ///
    /// - Parameter accuracy: Describes the maximum difference between the values of `expression1` and `expression2` for these values to be considered equal. Expressed in terms of `expression1.unit`. The default value is `0.0`.
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
    static func assertEqual<T: Dimension>(_ expression1: @autoclosure () throws -> Measurement<T>, _ expression2: @autoclosure () throws -> Measurement<T>, accuracy: Double = 0.0, _ message: @autoclosure () -> String = "", file: StaticString = #file, line: UInt = #line) {
        do {
            let e1 = try expression1()
            let e2 = try expression2()
            let errorMessage = [message(), "\"\(e1)\" is not equal to \"\(e2)\""].joined(separator: " – ", ignoreEmptyStrings: true)
            if accuracy == 0.0 {
                // Compare e1 and e2 directly
                XCTAssertEqual(e1, e2.converted(to: e1.unit), errorMessage, file: file, line: line)
            } else {
                // Compare e1's and e2's values, taking the specified accuracy into account.
                let value1 = e1.value
                let value2 = e2.converted(to: e1.unit).value
                XCTAssertEqual(value1, value2, accuracy: accuracy, errorMessage, file: file, line: line)
            }
        } catch {
            XCTFail("AmpereAssertEqual threw an error: \(error)")
        }
    }

    /// Custom variant of `XCTAssertEqual` for values of type `Measurement`.
    /// Asserts that both arguments are not only equal in value, but they also have the same unit.
    /// For example, the assertion fails for `a = 1 km and b = 1000 m`. The assertion passes for `a = 1 km and b = 1 km`.
    ///
    /// - Parameter accuracy: Describes the maximum difference between the values of `expression1` and `expression2` for these values to be considered equal. Expressed in terms of `expression1.unit`. The default value is `0.0`.
    static func assertEqualAndSameUnits<T: Dimension>(_ expression1: @autoclosure () throws -> Measurement<T>, _ expression2: @autoclosure () throws -> Measurement<T>, accuracy: Double = 0.0, _ message: @autoclosure () -> String = "", file: StaticString = #file, line: UInt = #line) {
        do {
            let e1 = try expression1()
            let e2 = try expression2()
            assertEqual(e1, e2, accuracy: accuracy, message(), file: file, line: line)
            let messageIfUnitsNotEqual = [message(), "\"\(e1.unit.symbol)\" is not the same unit as \"\(e2.unit.symbol)\""].joined(separator: " – ", ignoreEmptyStrings: true)
            XCTAssertTrue(e1.unit === e2.unit, messageIfUnitsNotEqual, file: file, line: line)
        } catch {
            XCTFail("AmpereAssertEqualAndSameUnit threw an error: \(error)")
        }
    }
}
