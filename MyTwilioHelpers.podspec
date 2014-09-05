Pod::Spec.new do |spec|
    
	spec.name		= 'MyTwilioHelpers'
	spec.version	= '0.0.3'
	spec.homepage   = "http://github.com/premosystems/MyTwilioHelpers"
	spec.author     = { "Vincil Bishop" => "vincil.bishop@vbishop.com" }
	spec.license	= 'MIT'
	spec.summary	= 'A collection of often used but time consuming to recreate logic for Twilio.'
	spec.source	= { :git => 'https://github.com/premosystems/MyTwilioHelpers.git', :tag => spec.version.to_s }
	spec.requires_arc = true
    
	spec.ios.deployment_target = '7.0'
    
	spec.resource = 'MyTwilioHelpers.podspec'
    
	spec.source_files = 'MyTwilioHelpers/*.{h,m}'
    spec.prefix_header_contents = '#import "TwilioClient.h"','#import "Lumberjack-Default-Log-Level.h"'
    spec.ios.dependency 'MyiOSHelpers/Logic/ThirdPartyHelpers/CocoaLumberjack', '~> 1.0'
    spec.dependency 'TwilioSDK', '~> 1.1'
end