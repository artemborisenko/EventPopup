Pod::Spec.new do |s|

# 1
s.platform = :ios
s.ios.deployment_target = '12.1'
s.name = "EventPopup"
s.summary = "EventPopup lets a user show an overlapping popup views"
s.requires_arc = true

# 2
s.version = "0.0.1"

# 3
s.license = { :type => "MIT", :file => "LICENSE" }

# 4
s.author = { "Artem Borisenko" => "37378677+artemborisenko@users.noreply.github.com" }

# 5
s.homepage = "https://github.com/artemborisenko/EventPopup"

# 6 - Replace this URL with your own Git URL from "Quick Setup"
s.source = { :git => "https://github.com/artemborisenko/EventPopup.git",
             :tag => "#{s.version}" }

# 7
s.framework = "UIKit"

# 8
s.source_files = "EventPopup/**/*.{swift}"

# 9
s.resources = "EventPopup/**/*.{png,jpeg,jpg,storyboard,xib,xcassets}"

# 10
s.swift_version = "5"

end
