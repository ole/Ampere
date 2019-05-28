#
# Be sure to run `pod lib lint Ampere.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
s.name = "Ampere"
s.version = "0.1.0"
s.summary = "Type-safe multiplication and division for Foundations measurements API."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

s.description = <<-DESC
An iOS library that extends Foundation’s units and measurements APIs with type-safe multiplication and division.
DESC

s.homepage = "https://github.com/ole/Ampere"
# s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
s.license = { :type => "MIT", :file => "LICENSE.txt" }
s.author = { "Ole Begemann" => "ole@oleb.net" }
s.source = { :git => "https://github.com/ole/Ampere.git", :tag => s.version.to_s }
# s.social_media_url = 'https://twitter.com/@olebegemann'

s.ios.deployment_target = "12.0"
s.swift_version = "5.0"

s.source_files = "Ampere/**/*.swift"
# s.resources = []
# s.resource_bundles = {
# }

# s.public_header_files = 'Pod/Classes/**/*.h'
# s.frameworks = 'Foundation'
s.test_spec "Tests" do |test_spec|
test_spec.source_files = "AmpereTests/**/*.{h,m,swift}"
end
end

