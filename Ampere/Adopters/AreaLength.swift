extension UnitArea: UnitSquare {
    public typealias Factor = UnitLength
    public typealias Product = UnitArea

    public static func defaultUnitMapping() -> (UnitLength, UnitLength, UnitArea) {
        return (.meters, .meters, .squareMeters)
    }
}
