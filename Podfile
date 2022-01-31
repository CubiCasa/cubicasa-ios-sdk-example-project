platform :ios, '13.4'

source 'https://cdn.cocoapods.org/'
source 'https://github.com/CubiCasa/podspecs.git'
 
target 'CubiCaptureDemo' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for CubiCaptureDemo
  pod 'CubiCapture', '~> 2.8'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
        config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
    end
  end
end
