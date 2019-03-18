

Pod::Spec.new do |s|


  s.name         = "XLStatusBarHUD"
  s.version      = "0.0.2"
  s.summary      = "自定义展示状态栏"

  s.description  = <<-DESC

            自定义展示状态栏,可以展示提示信息,可网络状态

                   DESC

  s.homepage     = "https://github.com/xiaoliangliu/XLStatusBarHUD"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"



  s.license      = 'MIT'

  s.author             = { "xiaoliang" => "xiaoliang@qq.com" }

  s.platform     = :ios, "5.0"


s.source       = { :git => "https://github.com/xiaoliangliu/XLStatusBarHUD.git", :tag => "v#{s.version}" }

  s.requires_arc = true

  s.frameworks = 'UIKit', 'QuartzCore', 'Foundation'

  s.source_files  = "XLStatusBarHUD", "XLStatusBarHUDDemo/XLStatusBarHUDDemo/XLStatusBarHUD/**/*.{h,m}"


end
