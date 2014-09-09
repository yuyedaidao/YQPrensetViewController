Pod::Spec.new do |s|
  s.name         = 'YQPresentViewController'
  s.version      = '1.0'
  s.license      =  :type => 'MIT'
  s.homepage     = 'https://github.com/yuyedaidao/YQPrensetViewController'
  s.authors      =  'yuyedaidao' => 'wyqpadding@gmail.com'
  s.summary      = '带导航的弹出视图控制器'

# Source Info
  s.platform     =  :ios, '7.0'
  s.source       =  :git => 'https://github.com/yuyedaidao/YQPrensetViewController.git', :tag => '1.0'
  s.source_files = 'YQPresentView/.{h,m}'

  s.requires_arc = true
  
# Pod Dependencies
  s.dependencies =	pod 'pop', '~> 1.0.6'
end