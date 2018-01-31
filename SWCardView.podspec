#
#  Be sure to run `pod spec lint SWCardView.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|


  s.name         = "SWCardView"
  s.version      = "0.1.0"
  s.summary      = "Simple way to create view like a badoo or a tinder."

  s.description  = <<-DESC
Simple way to create view like a badoo or a tinder. When you swipe that view, it's going out of screen.
                   DESC

  s.homepage     = "https://github.com/abramchuk-v/CardViews"



  s.license      = { :type => "Apache License", :file => "LICENSE" }



  s.author             = { "Uladzislau Abramchuk" => "abramchukv97@gmail.com" }

  s.platform     = :ios, "10.0"


  s.source       = { :git => "https://github.com/abramchuk-v/CardViews.git", :tag => "0.1.0" }

  s.source_files  = "testTind/TinderView/*"
  s.swift_version = "3.0"

end
