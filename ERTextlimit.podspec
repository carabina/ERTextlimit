#
# Be sure to run `pod lib lint ERTextlimit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ERTextlimit'
  s.version          = '0.1.3'
  s.summary          = 'Popup for TextView'

# This description is used to generate tags and improve search results.

  s.description      = <<-DESC
Add a pop-up charcter counter to your UITextField or UITextView. The pop-up bubble changes color when you reach the maximum allowed charcters.
                       DESC

  s.homepage         = 'https://github.com/earlred/ERTextlimit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'EarlRed' => '' }
  s.source           = { :git => 'https://github.com/earlred/ERTextlimit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'ERTextlimit/Classes/**/*'
  
  # s.resource_bundles = {
  #   'ERTextlimit' => ['ERTextlimit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
