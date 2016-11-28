#
# Be sure to run `pod lib lint VisualEffectView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|

    `xcodebuild -project VisualEffectView.xcodeproj -showBuildSettings` =~ /CURRENT_PROJECT_VERSION = ((\d\.)+\d)/
    abort("No version detected") if $1.nil?
    s.version = $1

    s.name             = "VisualEffectView"
    s.license          = 'MIT'
    s.homepage         = "https://github.com/efremidze/VisualEffectView"
    s.author           = { "Lasha Efremidze" => "efremidzel@hotmail.com" }
    s.summary          = "Dynamic blur background view with tint color (UIVisualEffectView subclass)"
    s.source           = { :git => 'https://github.com/efremidze/VisualEffectView.git', :tag => s.version }
    s.source_files     = "Sources/*.swift"
    s.ios.deployment_target = '8.0'
end
