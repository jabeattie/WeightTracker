# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'

workspace 'Weighttracker.xcworkspace'

target 'WeightTracker' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for WeightTracker
  pod 'Auth0', '~> 1.0'

  target 'WeightTrackerTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'WeightTrackerUITests' do
    # Pods for testing
  end

end

target 'API' do
  project 'API/API'
  use_frameworks!

  target 'APITests' do
    pod 'Nimble'
    pod 'Quick'  
  end

end

target 'Core' do
  project 'Core/Core'
  use_frameworks!

  target 'CoreTests' do
    pod 'Nimble'
    pod 'Quick'  
  end

end

target 'WeightUI' do
  project 'WeightUI/WeightUI'
  use_frameworks!

  pod 'SwiftGen', '~> 6.0'

  target 'WeightUITests' do
    pod 'Nimble'
    pod 'Quick'  
  end

end
