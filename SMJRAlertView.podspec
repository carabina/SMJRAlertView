

Pod::Spec.new do |s|

  s.name         = "SMJRAlertView"

  s.version      = "3.0.3"

  s.summary      = "SMAlertView -> custom alertView"

  s.description  = <<-DESC
 SMAlertView -> custom alertView, for SM
                   DESC

  s.homepage     = "https://github.com/TieShanWang/SMJRAlertView"

  s.license      = "MIT"

  s.author             = { "wangtieshan" => "15003836653@163.com" }

  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/TieShanWang/SMJRAlertView.git", :tag => "3.0.3" }

  s.framework  = "UIKit"

  s.source_files  = "SMAlertView/SMAlertView/**/*.{swift}"

end
