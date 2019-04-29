# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'

def pure_layout
    pod 'PureLayout', '3.1.4'                   # https://github.com/PureLayout/PureLayout/blob/master/PureLayout.podspec
end

def mapbox
    pod 'Mapbox-iOS-SDK', '~> 4.10.0'              # https://github.com/mapbox/mapbox-gl-native/releases/
end


target 'mapboxPerformanceIssues' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  mapbox
  pure_layout
  # Pods for mapboxPerformanceIssues

end


