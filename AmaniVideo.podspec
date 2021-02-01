#
#  Be sure to run `pod spec lint Amani.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|


  spec.name         = "AmaniVideo"
  spec.version      = "1.0.0"
  spec.summary      = "A short description of AmaniVideoSDK."
  spec.description  = "The knob control is a completely customizable widget that can be used in any iOS app. It also plays a little victory fanfare."
  spec.homepage     = "http://EXAMPLE/AmaniSDK"
  spec.license      = "MIT"
  spec.author             = { "Pratul" => "pratul.dawande@unthinkable.co" }
  spec.platform     = :ios, "5.0"
  spec.source       = { :git => 'https://github.com/pratuldawande/AmaniVideo.git', :tag => "#{spec.version}"}
  spec.dependency 'Alamofire'
  spec.dependency 'SwiftLint'
  spec.dependency 'iProgressHUD'
  spec.dependency 'IQKeyboardManagerSwift'
  spec.dependency "OpenSSL-Universal/Framework"
  spec.dependency 'IISightSDK'
  spec.ios.deployment_target = '11.0'
  spec.vendored_frameworks = 'AmaniVideo.framework'
  

end
