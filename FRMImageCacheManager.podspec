Pod::Spec.new do |s|
  s.name             = 'FRMImageCacheManager'
  s.version          = '0.3.7'
  s.summary          = 'An image cache manager that uses more than the "default" image cache.'
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
  s.dependency 'SDWebImage', '= 4.0.0-beta2'
end
