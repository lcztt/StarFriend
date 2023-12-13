# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'StarFriend' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  pod 'RxSwift', '6.6.0'
  pod 'RxCocoa', '6.6.0'
  pod 'RxDataSources', '~> 5.0'
  pod 'RxGRDB'
  pod 'RxGRDB/SQLCipher'
  pod 'SnapKit'
  pod 'SwiftyStoreKit' # 内购
  pod 'PromiseKit'
  pod 'Kingfisher'

#  pod 'Alamofire' # 网络
  pod 'Toast-Swift', '~> 5.0.1'
#  pod 'SVProgressHUD'

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
