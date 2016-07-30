# Ampere

By [Ole Begemann][Ole Begemann], July 2016

An iOS library that extends Foundation’s units and measurements APIs with type-safe multiplication and division.

## Example

~~~swift
let speed = Measurement(value: 20, unit: UnitSpeed.kilometersPerHour)
// → 20.0 km/h
let time = Measurement(value: 2, unit: UnitDuration.hours)
// → 2.0 hr
let distance: Measurement<UnitLength> = speed * time
// → 40000.032 m 🎉
~~~

## Usage

The library is packaged as an Xcode project that builds an iOS Framework target. I have not (yet) set it up for CocoaPods, Carthage, or the Swift Package Manager. (Although I assume Carthage should build it out of the box.)

Clone the repository, open the project in Xcode, and check out the tests. If you want to use this in your own project in the current form, drag and drop the project file into your Xcode project and add the framework to your linked libraries, or copy the files directly into your project.

## Dependencies

None except Swift 3 and Foundation.

## More Information

I wrote a series of blog posts about this: [Part 1], [Part 2], [Part 3].

## License

MIT License. See LICENSE file for details.

[Ole Begemann]: http://oleb.net/
[Part 1]: http://oleb.net/blog/2016/07/measurements-and-units/
[Part 2]: http://oleb.net/blog/2016/07/unitproduct/
[Part 3]: http://oleb.net/blog/2016/07/unitsquare/
