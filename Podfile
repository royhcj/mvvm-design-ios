workspace 'CleanArchDesign'
platform :ios, '13.0'

project 'CleanArcDesign.xcodeproj'
project 'CleanArcDesign/Utilities/Utilities.xcodeproj'

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
