Pod::Spec.new do |s|
s.name             = "POPupSidebar"
s.version          = "0.1.32"
s.summary          = "Quick custom sidebar for Object-C project."
s.homepage         = "https://github.com/popeveryday/POPupSidebar"
s.license          = 'MIT'
s.author           = { "popeveryday" => "popeveryday@gmail.com" }
s.source           = { :git => "https://github.com/popeveryday/POPupSidebar.git", :tag => s.version.to_s }
s.platform     = :ios, '7.1'
s.requires_arc = true
s.source_files = 'Pod/Classes/**/*.{h,m,c}'
s.resources = 'Pod/Classes/*.bundle'
s.dependency 'POPLib', '~> 0.1'
s.dependency 'AFNetworking', '~> 2.5'
s.dependency 'PureLayout'
end