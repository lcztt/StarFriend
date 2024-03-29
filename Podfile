# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'StarFriend' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  pod 'SnapKit'
  pod 'Kingfisher'
  pod 'Alamofire'
  pod 'GRDB.swift'
  
  pod 'RxSwift', '6.6.0'
  pod 'RxCocoa', '6.6.0'
  pod 'RxDataSources', '~> 5.0'
  pod "RxGesture"
  #  pod 'RxCoreLocation', '~> 1.5.1'
  pod 'PromiseKit'
  
  pod "Position", "~> 0.7.0" # 定位
  pod 'SwiftyStoreKit' # 内购
  
  pod 'JXPhotoBrowser', '~> 3.0'
  pod 'JFPopup', '1.5.4' # replaced with popupview smp
  pod 'AMPopTip' # 提示
  pod 'Toast-Swift', '~> 5.0.1'
  pod 'BRPickerView'
  
  pod 'UMCommon' # 友盟统计

  post_install do |installer|
    installer.generated_projects.each do |project|
      project.targets.each do |target|
        target.build_configurations.each do |config|
          config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0'
        end
      end
    end
  end
end
