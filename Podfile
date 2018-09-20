# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'habitapp' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for habitapp
  pod 'SnapKit'
  pod 'Charts'
  pod 'RealmSwift'
  pod 'M13Checkbox'

  target 'habitappTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'Quick'
    pod 'Nimble'
  end

  target 'habitappUITests' do
    inherit! :search_paths
    # Pods for testing
    pod 'Quick'
    pod 'Nimble'
  end

  target 'today' do
    pod 'SnapKit'
    pod 'Charts'
    pod 'RealmSwift'
    pod 'M13Checkbox'
  end
  
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '4.1'
    end
  end
end