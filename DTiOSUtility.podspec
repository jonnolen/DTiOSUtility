#
# Be sure to run `pod spec lint DTiOSUtility.podspec' to ensure this is a
# valid spec.
#
# Remove all comments before submitting the spec. Optional attributes are commented.
#
# For details see: https://github.com/CocoaPods/CocoaPods/wiki/The-podspec-format
#
Pod::Spec.new do |s|
  s.name         = "DTiOSUtility"
  s.version      = "0.0.5"
  s.summary      = "Utility classes common across Developer Town internal projects."
  s.description  = "a description."
  s.homepage     = "http://github.com/jonnolen/DTiOSUtility"

  s.license      = "MIT"
  
  s.author       = { "Jon Nolen" => "jon.nolen@gmail.com" }
  s.source       = { :git => "https://github.com/jonnolen/DTiOSUtility.git", :commit=>"5310219"}
  s.platform     = :ios, "5.0"
  s.source_files = 'Classes', 'DTiOSUtility/*.{h,m}'

  s.public_header_files = 'DTiOSUtility/*.h'
  s.frameworks = 'UIKit', 'CoreData', 'QuartzCore'

  s.requires_arc = true

  s.dependency "TestFlightSDK", "1.1"
  
end
