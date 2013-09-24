Pod::Spec.new do |s|
  s.name         = "DTiOSUtility"
  s.version      = "0.0.12"
  s.summary      = "Utility classes common across Developer Town internal projects."
  s.description  = "a description."
  s.homepage     = "http://github.com/jonnolen/DTiOSUtility"

  s.license      = "MIT"
  
  s.author       = { "Jon Nolen" => "jon.nolen@gmail.com" }
  s.source       = { :git => "https://github.com/jonnolen/DTiOSUtility.git", :commit=>"687bdca6f072d9c9e1bb0c9d336da68945ad08ef"}
  s.platform     = :ios, "5.0"
  s.source_files = 'Classes', 'DTiOSUtility/*.{h,m}'

  s.public_header_files = 'DTiOSUtility/*.h'
  s.frameworks = 'UIKit', 'CoreData', 'QuartzCore'

  s.requires_arc = true

  s.dependency "TestFlightSDK", "~>2.0"
  s.dependency "SSToolkit", "~>1.0.4"
  s.dependency "libextobjc", "~> 0.3"
end
