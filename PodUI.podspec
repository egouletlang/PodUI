
Pod::Spec.new do |s|

  s.platform = :ios
  s.ios.deployment_target = '10.0'

  s.name         = "PodUI"
  s.version      = "1.0.28"
  s.summary      = "PodUI classes"
  s.description  = <<-DESC
  A bunch of classes i have found useful for PodUI
                   DESC

  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Etienne Goulet-Lang" => "" }
  s.source       = { :git => "https://github.com/egouletlang/PodUI.git", :tag => "#{s.version}" }

  s.homepage = "https://github.com/egouletlang/PodUI"

  s.source_files  = "PodUI", "PodUI/**/*.{h,m}", "PodUI/**/*.{swift}"
  s.exclude_files = "Classes/Exclude"

  s.dependency 'BaseUtils'
  s.dependency 'PodImage'

end

