#
# Be sure to run `pod lib lint VisualEffectView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = "VisualEffectView"
    s.version          = "3.1.1"
    s.license          = 'MIT'
    s.homepage         = "https://github.com/efremidze/VisualEffectView"
    s.author           = { "Lasha Efremidze" => "efremidzel@hotmail.com" }
    s.documentation_url = 'https://efremidze.github.io/VisualEffectView/'
    s.summary          = "Dynamic blur background view with tint color (UIVisualEffectView subclass)"
    s.source           = { :git => 'https://github.com/efremidze/VisualEffectView.git', :tag => s.version }
    s.source_files     = "Sources/*.swift"
    s.ios.deployment_target = '9.0'
end
