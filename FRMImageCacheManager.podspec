#
# Be sure to run `pod lib lint FRMImageCacheManager.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'FRMImageCacheManager'
  s.version          = '0.3'
  s.summary          = 'An image cache manager that uses more than the "default" image cache.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
An image cache manager that uses more than the "default" image cache.
This is built on top of the SDWebImage library, for use with multiple image caches.
                       DESC

  s.homepage         = 'https://github.com/William500/FRMImageCacheManager.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Vilmantas' => 'vilm1s.vb@gmail.com' }
  s.source           = { :git => 'https://github.com/William500/FRMImageCacheManager.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.1'

  s.source_files = 'FRMImageCacheManager/Classes/**/*'
  
  # s.resource_bundles = {
  #   'FRMImageCacheManager' => ['FRMImageCacheManager/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
    s.dependency 'SDWebImage'
end
