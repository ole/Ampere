# Ampere

By [Ole Begemann][Ole Begemann], July 2016

An iOS library that extends Foundation’s units and measurements APIs with type-safe multiplication and division.

[![Build Status](https://travis-ci.org/ole/Ampere.svg?branch=master)](https://travis-ci.org/ole/Ampere)


## Requirements

Swift 5.0 or higher.


## Dependencies

Foundation


## Examples

To compute a velocity, we can divide length by time, i.e. `Measurement<UnitLength> / Measurement<UnitDuration>`:

~~~swift
import Ampere

let length = Measurement(value: 100, unit: UnitLength.meters)
let time = Measurement(value: 10, unit: UnitDuration.seconds)
let speed = length / time
// → 10.0 m/s 🎉
~~~

To compute energy, multiply power by time, i.e. `Measurement<UnitPower> * Measurement<UnitDuration>`:

~~~swift
import Ampere

let power = Measurement(value: 20, unit: UnitPower.kilowatts)
let time = Measurement(value: 3, unit: UnitDuration.hours)
let energy: Measurement<UnitEnergy> = power * time
// → 216000000.0 J
energy.converted(to: .kilowattHours)
// → 60.0 kWh
~~~

Notice that in this case we had to explicitly specify the type of the `energy` variable in `let energy: Measurement<UnitEnergy>`. Sometimes the compiler cannot infer the correct type automatically and we have to help it.


## Usage

The library is packaged as an Xcode project that builds an iOS Framework target. I have not (yet) set it up for CocoaPods, Carthage, or the Swift Package Manager. (Although I assume Carthage should build it out of the box.)

Clone the repository, open the project in Xcode, and check out the tests. If you want to use this in your own project in the current form, drag and drop the project file into your Xcode project and add the framework to your linked libraries, or copy the files directly into your project.


## Additional Units

This library defines the following custom units because they are not included in Foundation:

- `UnitForce`, measured in newtons. The base unit is `.newtons`.


## Implemented Relations

This library currently defines the following relations:

| Relation                       | Example               |
| -------------                  | -------------         |
| area = length × length         | 1 m² = 1 m × 1 m      |
| volume = area × length         | 1 m³ = 1 m² × 1 m     |
| density = mass / volume        | 1 kg/m³ = 1 kg / 1 m³ | 
| velocity = length / time       | 1 m/s = 1 m / 1 s     |
| acceleration = velocity / time | 1 m/s² = 1 m/s / 1 s  |
| energy = power × time          | 1 J = 1 W × 1 s       |
| resistance = voltage / current | 1 Ω = 1 V / 1 A       |
| charge = current × time        | 1 C = 1 A × 1 s       |
| force = mass × acceleration    | 1 N = 1 kg × 1 m/s²   |


## Adding Relations

Missing something? Pull requests welcome! It’s very easy to add additional relations. All you have to do is to conform your desired type to the `UnitProduct` protocol, like so:

~~~swift
/// Energy = Power * Duration
/// 1 J = 1 W * 1 s
extension UnitEnergy: UnitProduct {
    public typealias Factor1 = UnitPower
    public typealias Factor2 = UnitDuration
    public typealias Product = UnitEnergy

    public static func defaultUnitMapping() -> (Factor1, Factor2, Product) {
        return (.watts, .seconds, .joules)
    }
}
~~~

This says that the conforming type `UnitEnergy` is the product of the two associated types `Factor1` (`UnitPower`) and `Factor2` (`UnitDuration`).

The `defaultUnitMapping` method defines the units for the three types that should be used for computations. By returning `(.watts, .seconds, .joules)`, we say that _1 W × 1 s = 1 J_. These must be consistent so that the resulting equation is valid. We could just as well have returned `(.kilowatts, .hours, .kilowattHours)`, but something like `(.watts, .hours, .joules)` would produce wrong results.

Note that Ampere expresses all relations as _products_, i.e. multiplications. If you want to express a ratio, such as _speed = length / time_, you first have to rearrange the equation into a multiplication, i.e. _length = speed × time_. This is why this particular relation is defined on `UnitLength` and not `UnitSpeed`. A separate protocol for ratios of units should not be necessary because every ratio can be transformed into an equivalent product equation.

For units that are the _square_ of another units, i.e. where both factors of the product are the same type, use the `UnitSquare` protocol. An existing example of this is `UnitArea`, which is `UnitLength * UnitLength`.


## Limitations

Currently [some relations cannot be expressed](https://github.com/ole/Ampere/issues/5) due to conflicts with other definitions. As an example, consider the relation _pressure = force / area_. In Ampere, we would express this in terms of _force = pressure × area_ because all relations are expressed as multiplications (see above).

However, _force = pressure × area_ conflicts with the existing _force = mass × acceleration_ — `UnitForce` can only conform once to `UnitProduct` so we cannot express both of these. It could be that the only solution is to introduce a separate `UnitRatio` protocol after all, but that’s not implemented yet.


## More Information

I wrote a series of blog posts about this: [Part 1], [Part 2], [Part 3]. Part 2 in particular explains the implementation in a lot of detail.


## License

MIT License. See LICENSE file for details.

[Ole Begemann]: http://oleb.net/
[Part 1]: http://oleb.net/blog/2016/07/measurements-and-units/
[Part 2]: http://oleb.net/blog/2016/07/unitproduct/
[Part 3]: http://oleb.net/blog/2016/07/unitsquare/
