# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "siriproxy-nba"
  s.version     = "0.0.1" 
  s.authors     = ["vinced45"]
  s.email       = [""]
  s.homepage    = ""
  s.summary     = %q{An Siri Proxy Plugin for NBA Scores}
  s.description = %q{A plugin for SiriProxy that will allow you to check NBA Scores}

  s.rubyforge_project = "siriproxy-nba"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
  
  s.add_runtime_dependency "nokogiri"
end
