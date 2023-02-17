# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

def shared_pods
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for CleanArcDesign
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

target 'CleanArcDesign' do
  shared_pods
#  # Comment the next line if you don't want to use dynamic frameworks
#  use_frameworks!
#
#  # Pods for CleanArcDesign
#  pod 'RxSwift'
#  pod 'RxCocoa'
#  pod 'RxOptional'
#
#  # Networking
#  pod 'IORequestable'
#  pod 'Kingfisher'
#
#  # Layout
#  pod 'SnapKit'

end

target 'CleanArcDesignTests' do
  shared_pods
  
  inherit! :search_paths
end
