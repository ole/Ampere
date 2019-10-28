extension Sequence where Iterator.Element == String {
    /// Returns a new string by concatenating the elements of the sequence, adding the given separator between each element. If `ignoreEmptyStrings` is `true`, empty strings will be ignored.
    func joined(separator: String, ignoreEmptyStrings: Bool) -> String {
        if ignoreEmptyStrings {
            let filtered = filter { $0 != "" }
            return filtered.joined(separator: separator)
        } else {
            return joined(separator: separator)
        }
    }
}
