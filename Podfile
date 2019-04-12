# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'

target 'InTune' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  inhibit_all_warnings!

  # Pods for InTune

  pod 'Haneke'
  pod 'JGProgressHUD'
  pod 'Moya'
  pod 'RxSwift'
  pod 'RxCocoa'

  target 'InTuneTests' do
    inherit! :search_paths
    pod 'KIF', :configurations => ['Debug']
    pod 'RxTest'
    pod 'RxBlocking'
  end

  target 'InTuneUITests' do
    inherit! :search_paths
  end

end
