platform :ios, '7.0'
pod 'APParallaxHeader', '~> 0.1.6'

link_with 'break.', 'break. WatchKit Extension'

post_install do | installer |
  require 'fileutils'
  FileUtils.cp_r('Pods/Target Support Files/Pods/Pods-Acknowledgements.plist', 'break./Settings.bundle/Acknowledgements.plist', :remove_destination => true)
end
