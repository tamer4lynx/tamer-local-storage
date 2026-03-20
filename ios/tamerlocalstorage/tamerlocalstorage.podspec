package = JSON.parse(File.read(File.join(__dir__, "..", "..", "package.json")))
author_string = package["author"]
package_description = package["description"]

author_match = author_string.match(/(?<name>.*) <(?<email>.*)> \((?<url>.*)\)/)

author_name = author_match ? author_match[:name] : "Unknown"
author_email = author_match ? author_match[:email] : ""
homepage_url = author_match ? author_match[:url] : "https://github.com"

Pod::Spec.new do |s|
  s.name             = 'tamerlocalstorage'
  s.version          = package["version"]
  s.summary          = 'Local persistent storage for Lynx applications'

  s.description      = package_description

  s.homepage     = homepage_url
  s.authors      = { author_name => author_email }
  
  s.license      = package["license"]
  s.source       = { :path => '.' }
  s.ios.deployment_target = '13.0'

  s.swift_version = '5.0'
  s.source_files = 'tamerlocalstorage/Classes/**/*.swift'
  s.dependency "Lynx"
end
