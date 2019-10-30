Pod::Spec.new do |s|
  s.name = 'PetStore'
  s.ios.deployment_target = '9.0'
  s.osx.deployment_target = '10.11'
  s.tvos.deployment_target = '9.0'
  s.version = '1.0.3'
  s.source = { :git => 'git@github.com:OpenAPITools/openapi-generator.git', :tag => 'v1.0.3' }
  s.authors = 'Daiki Matsudate'
  s.license = 'Proprietary'
  s.homepage = 'https://github.com/d-date/APIClient'
  s.summary = 'API Clinent for Petstore'
  s.source_files = 'PetStore/Classes/**/*.swift'
end
