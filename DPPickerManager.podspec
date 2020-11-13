Pod::Spec.new do |s|

  s.name             = "DPPickerManager"
  s.version          = "1.0.3"
  s.summary          = "UIPicker inside a UIAlertController."
  
  s.homepage         = "https://github.com/priore/DPPickerManager"
  s.license          = 'MIT'
  s.authors 		 = { 'Danilo Priore' => 'support@prioregroup.com' }
  s.source           = { :git => "https://github.com/priore/DPPickerManager.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/danilopriore'

  s.platform     = :ios, "10.0"
  s.ios.deployment_target = '10.0'
  s.requires_arc = true
  s.framework    = 'UIKit'
  s.source_files = 'DPPickerManager/Class/*.swift'
  s.resources    = 'DPPickerManager/Resources/**/*'
  s.swift_versions = ['3.0', '4.2', '5.0']

end
