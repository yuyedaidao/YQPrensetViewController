Pod::Spec.new do |s|
  s.name         = 'YQPresentController'
  s.version      = '0.0.2'
  s.license      = 'MIT'
  s.homepage     = 'https://github.com/yuyedaidao/YQPrensetViewController'
  s.authors      =  {'yuyedaidao' => 'wyqpadding@gmail.com'}
  s.summary      = '带导航的弹出视图控制器'

# Source Info
  s.platform     =  :ios, '6.0'
  s.source       =  {:git => 'https://github.com/yuyedaidao/YQPrensetViewController.git', :tag => '0.0.2'}
  s.source_files = 'YQPresentView/*.{h,m}'

  s.requires_arc = true
  
# Pod Dependencies
  s.dependency 'pop', '~> 1.0.6'
end