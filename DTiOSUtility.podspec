Pod::Spec.new do |s|
  s.name         = "DTiOSUtility"
  s.version      = "0.0.15"
  s.summary      = "Utility classes common across Developer Town internal projects."
  s.description  = "a description."
  s.homepage     = "http://github.com/jonnolen/DTiOSUtility"

  s.license      = "MIT"
  
  s.author       = { "Jon Nolen" => "jon.nolen@gmail.com" }
  s.source       = { :git => "https://github.com/jonnolen/DTiOSUtility.git"}
  s.platform     = :ios, "6.1"
  s.source_files = 'Classes', 'DTiOSUtility/*.{h,m}'

  s.public_header_files = 'DTiOSUtility/*.h'
  s.frameworks = 'UIKit', 'CoreData', 'QuartzCore'

  s.requires_arc = true

# Rewrite references to libextobjc to use the pod's files.
#  s.prepare_command = <<-'END'
#     find . \( -name '*.h' -o -name '*.m' \) \
#        -exec sed -i '' -E 's@<DTiOSUtility/(EXTScope|metamacros)\.h>@<\1.h>@' {} +
#  END

  s.dependency "TestFlightSDK", "~>2.0"
  s.dependency "SSToolkit", "~>1.0.4"
  s.dependency "libextobjc/EXTScope", "~> 0.3"
end
