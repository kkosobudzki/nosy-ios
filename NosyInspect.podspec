Pod::Spec.new do |s|
  s.name             = 'NosyInspect'
  s.version          = '1.0.3'
  s.summary          = 'Nosy Inspect'
  s.homepage         = 'https://github.com/kkosobudzki/nosy-ios'
  s.license          = { :type => 'GNUv3', :file => 'LICENSE.md' }
s.author           = { 'Krzysztof Kosobudzki' => 'krzysztof.kosobudzki@gmail.com' }
  s.source           = { :git => 'https://github.com/kkosobudzki/nosy-ios.git', :tag => s.version.to_s }
  s.ios.deployment_target = '13.0'
  s.swift_version = '5.0'
  s.source_files = 'Sources/NosyInspect/**/*'
end
