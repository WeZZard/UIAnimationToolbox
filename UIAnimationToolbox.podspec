Pod::Spec.new do |spec|
  spec.name             	= "UIAnimationToolbox"
  spec.version          	= "0.0.3"
  spec.license          	= { :type => "MIT", :file => "LICENSE" }
  spec.homepage         	= 'https://github.com/WeZZard/UIAnimationToolbox'
  spec.author           	= { "WeZZard" => "https://wezzard.com" }
  spec.summary          	= "A framework makes use of advanced Core Animation features without leaving UIKit."
  spec.source           	= { :git => "https://github.com/WeZZard/UIAnimationToolbox.git", :tag => '0.0.3'}
  spec.source_files     	= 'UIAnimationToolbox/**/*.{swift,m}'
  spec.module_name		= 'UIAnimationToolbox'
  spec.ios.deployment_target	= '8.0'
  spec.swift_versions		= ['5.1', '5.0', '4.2']
end
