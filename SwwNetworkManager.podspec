
Pod::Spec.new do |s|
  s.name             = 'SwwNetworkManager'
  s.version          = '0.2.0'
  s.summary          = 'A short description of SwwNetworkManager.'

  s.homepage         = 'https://github.com/IdonotdrinkSWW/SwwNetworkManager.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'bhshuangww' => '1248536589@qq.com' }
  s.source           = { :git => 'git@github.com:IdonotdrinkSWW/SwwNetworkManager.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'

  s.source_files = 'SwwNetworkManager/Commons/*'
  
  # s.resource_bundles = {
  #   'SwwNetworkManager' => ['SwwNetworkManager/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
   s.dependency 'AFNetworking', '~> 4.0'
end
