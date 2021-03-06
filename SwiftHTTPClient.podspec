Pod::Spec.new do |spec|
  spec.name             = "SwiftHTTPClient"
  spec.version          = "0.1.4"
  spec.swift_version    = '5.0'
  spec.summary          = "SwiftHTTPClient is a swift HTTP client library."
  spec.description      = <<-DESC
                            SwiftHTTPClient is a swift HTTP client library.
                            It helps to handle a HTTP request or response as an object.
                          DESC
  spec.homepage         = "https://github.com/geonu1109/SwiftHTTPClient"
  spec.license          = { :type => 'MIT', :file => 'LICENSE' }
  spec.license          = "MIT"
  spec.author           = { "Geonu Jeon" => "geonu1109@gmail.com" }
  spec.platform         = :ios, "13.0"
  spec.source           = { :git => "https://github.com/geonu1109/SwiftHTTPClient.git", :tag => "#{spec.version}" }
  spec.source_files     = "SwiftHTTPClient/**/*.swift"
end
