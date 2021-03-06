#
# Be sure to run `pod lib lint AOCKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AOCKit'
  s.version          = '0.1.0'
  s.summary          = 'A short description of AOCKit.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
                        A kit with test
                       DESC

  s.homepage         = 'https://github.com/doukeuu/AOCKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'pan' => '' }
  s.source           = { :git => 'https://github.com/doukeuu/AOCKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'AOCKit/Classes/**/*'
  
  s.resource = 'AOCKit/Assets/AOCImage.bundle'
  
  # s.resource_bundles = {
  #   'AOCKit' => ['AOCKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  
  s.dependency 'AFNetworking',  '4.0.1'
  s.dependency 'Masonry',       '1.1.0'
  s.dependency 'DeepLinkKit',   '1.5.1'
  s.dependency 'Aspects',       '1.4.1'
  s.dependency 'MBProgressHUD', '1.2.0'
  
end
