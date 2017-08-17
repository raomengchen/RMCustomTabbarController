Pod::Spec.new do |s|
    s.name         = "RMCustomTabbarController"
    s.version      = "1.1.6"
    s.summary      = "custom RMTabBar"
    s.homepage     = "https://github.com/raomengchen/RMCustomTabbarController"
    s.license      = "MIT"
    s.authors      = {"raomeng" => "raomeng915@163.com"}
    s.platform     = :ios, "7.0"
    s.source       = {:git => "https://github.com/raomengchen/RMCustomTabbarController.git", :tag => s.version}
    s.source_files = "RMCustomTabbarController/*.{h,m}"
    s.requires_arc = true
end