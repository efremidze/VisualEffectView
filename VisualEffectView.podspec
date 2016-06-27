#
# Be sure to run `pod lib lint VisualEffectView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = "VisualEffectView"
    s.version          = "1.0.4"
    s.summary          = "VisualEffectView"
    s.homepage         = "https://github.com/efremidze/VisualEffectView"
    s.license          = 'MIT'
    s.author           = { "Lasha Efremidze" => "efremidzel@hotmail.com" }
    s.ios.deployment_target = '8.0'
    s.source           = { :git => 'https://github.com/efremidze/VisualEffectView.git', :tag => s.version }
    s.source_files     = "Sources/*.swift"
    s.requires_arc     = true
end
