/// Area = Length * Length
/// 1 m² = 1 m * 1 m
extension UnitArea: UnitSquare {
    public typealias Factor = UnitLength
    public typealias Product = UnitArea

    public static func defaultUnitMapping() -> (UnitLength, UnitLength, UnitArea) {
        return (.meters, .meters, .squareMeters)
    }
}
