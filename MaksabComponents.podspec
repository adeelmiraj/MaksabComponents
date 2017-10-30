#
# Be sure to run `pod lib lint MaksabComponents.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MaksabComponents'
  s.version          = '0.1.20'
  s.summary          = 'Maksab reusable components.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Maksab reusable components.Components that are reused or used in both rider and driver side.
                       DESC

  s.homepage         = 'https://github.com/mansoor92/MaksabComponents'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Mansoor Ali' => 'mali92390@gmail.com' }
  s.source           = { :git => 'https://github.com/mansoor92/MaksabComponents.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'MaksabComponents/Classes/**/*.{h,m,swift}'
  s.resources = 'MaksabComponents/Classes/**/*.{xib,ttf}'
#s.resources = 'MaksabComponents/Classes/**/*.{xib}'

#s.resource_bundles = {
#   'MaksabComponents' => ['MaksabComponents/Classes/*.{xib}']
#  }

 s.resource_bundles = {
     'MaksabComponents' => ['MaksabComponents/Assets/*.png']
 }

  # s.public_header_files = 'Pod/Classes/**/*.h'
    s.frameworks = 'UIKit'
    s.requires_arc     = true
    s.dependency 'StylingBoilerPlate'
    s.dependency 'Cosmos', '11.0.3'
    s.dependency 'KMPlaceholderTextView'

end
