workspace 'CleanArchDesign'
platform :ios, '13.0'
inhibit_all_warnings!

#project 'CleanArcDesign.xcodeproj'
#project 'CleanArcDesign/Utilities/Utilities.xcodeproj'
#project 'CleanArcDesign/Services/Services.xcodeproj'
#project 'CleanArcDesign/Scenes/Scenes.xcodeproj'

def shared_pods
  use_frameworks!

  # Rx
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'RxOptional'
  pod 'RxViewController'
  
  # Networking
  pod 'IORequestable'
  pod 'Kingfisher'

  # Layout
  pod 'SnapKit'
end

target :CleanArcDesign do
  project 'CleanArcDesign.xcodeproj'
  shared_pods
end

target :Utilities do
  use_frameworks!
  project 'CleanArcDesign/Utilities/Utilities.xcodeproj'
  
  target 'Utilities' do
    shared_pods
  end
  
  target 'UtilitiesTests' do
    shared_pods
  end
end

target :Services do
  use_frameworks!
  project 'CleanArcDesign/Services/Services.xcodeproj'
  
  target 'Services' do
    shared_pods
  end
  
  target 'ServicesTests' do
    shared_pods
  end
end


target :Scenes do
  use_frameworks!
  project 'CleanArcDesign/Scenes/Scenes.xcodeproj'
  
  target 'Scenes' do
    shared_pods
  end
  
  target 'ScenesTests' do
    shared_pods
  end
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
      config.build_settings['CODE_SIGNING_ALLOWED'] = 'NO'
    end
  end
end
