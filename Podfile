# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'

def shared_pods
  use_frameworks!

  pod 'MobilliumBuilders', '~> 1.3'
  pod 'MobilliumUserDefaults', '~> 2.0'
  pod 'MobilliumDateFormatter', '~> 1.2'
  pod 'TinyConstraints', '~> 4.0'
  pod 'Kingfisher', :git => 'https://github.com/onevcat/Kingfisher', :branch => 'version6-xcode13'
end

workspace 'applogist_case'

target 'applogist_case' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for applogist_case
  pod 'Alamofire', '~> 5.4'
  shared_pods

  # Lint
  pod 'SwiftLint', '~> 0.43'

  # Helper
  pod 'IQKeyboardManagerSwift'
  pod 'MobilliumUserDefaults'

  # UI
  pod 'SwiftEntryKit', '2.0.0'
  
  # Auth
  pod 'GoogleSignIn'
  pod 'FBSDKCoreKit'
  pod 'FBSDKLoginKit'
  pod 'FBSDKShareKit'
  
  # FireBase
  pod 'FirebaseCore'
  pod 'FirebaseAnalytics'
  pod 'FirebaseAuth'
  pod 'FirebaseFirestore'

end


target 'UIComponents' do
  
  project 'UIComponents/UIComponents.xcodeproj'
  
  # Pods for UIComponents
  shared_pods
  
  # Generater
  pod 'SwiftGen', '~> 6.5.1'
  
  # Helper
  pod 'MobilliumUserDefaults'
  
  # UI

end

target 'DataProvider' do
  
  project 'DataProvider/DataProvider.xcodeproj'
  
  # Pods for DataProvider
  
  # Network
  pod 'Alamofire', '~> 5.4'
  
  # Helper
  pod 'MobilliumUserDefaults'

end

target 'Utilities' do
  
  project 'Utilities/Utilities.xcodeproj'

  # Pods for Utilities
  
  # Helper
  pod 'MobilliumUserDefaults'

end

