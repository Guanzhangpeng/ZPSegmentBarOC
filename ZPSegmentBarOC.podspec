#
# Be sure to run `pod lib lint ZPSegmentBarOC.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ZPSegmentBarOC'
  s.version          = '0.1.2'
  s.summary          = '仿今日头条导航栏'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: 仿今日头条 网易新闻 导航栏效果 OC版本
                       DESC

  s.homepage         = 'https://github.com/Guanzhangpeng/ZPSegmentBarOC.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zswangzp@163.com' => 'zswangzp@163.com' }
  s.source           = { :git => 'https://github.com/Guanzhangpeng/ZPSegmentBarOC.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

#s.source_files = 'ZPSegmentBarOC/Classes/**/*.h'
#s.public_header_files = 'ZPSegmentBarOC/Classes/**/*.h'
#s.vendored_framework = 'ZPSegmentBarOC/Products/ZPSegmentBarLib.framework'


#二进制化
   if ENV['IB']
     s.public_header_files = 'ZPSegmentBarOC/Classes/**/*.h'
     s.vendored_framework = 'ZPSegmentBarOC/Products/ZPSegmentBarLib.framework'
   else
     s.source_files = 'ZPSegmentBarOC/Classes/**/*'
   end


  # s.resource_bundles = {
  #   'ZPSegmentBarOC' => ['ZPSegmentBarOC/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
