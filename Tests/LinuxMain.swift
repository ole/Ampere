import XCTest
@testable import AmpereTests

XCTMain([
     testCase(DivisionByItselfTests.allTests),
     testCase(UnitAreaTests.allTests),
     testCase(UnitElectricChargeTests.allTests),
     testCase(UnitElectricPotentialDifferenceTests.allTests),
     testCase(UnitEnergyTests.allTests),
     testCase(UnitForceTests.allTests),
     testCase(UnitLengthTests.allTests),
     testCase(UnitMassTests.allTests),
     testCase(UnitProductTests.allTests),
     testCase(UnitSpeedTests.allTests),
     testCase(UnitVolumeTests.allTests),
])
