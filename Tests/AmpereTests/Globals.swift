/// The acceptable deviation for floating-point values to be considered equal.
///
/// This value must be uncomfortably large for some computations, indicating that converting all values to the default unit mappings, performing the calculation, and then converting them back is not the best way to do it if you're aiming for maximum accuracy.
let epsilon = 0.001
