require 'rubygems'
require 'fileutils'
require 'git'


@clone_urls = {:ruby_processing => 'git://github.com/jashkenas/ruby-processing.git',
               :jruby => 'git://github.com/jruby/jruby.git',
               :chipmunk_ffi =>'git://github.com/shawn42/chipmunk-ffi.git',
               :nice_ffi => 'git://github.com/jacius/nice-ffi.git',
               :ffi_jruby =>'git://github.com/ffi/ffi-jruby.git'}

def download_gem(spec)
  Gem::RemoteFetcher.fetcher().download(spec, Gem.default_sources()[0], ".")
end

task :fetch_gems do
  ["nice-ffi", "chipmunk-ffi"].each do |gem_name|
    dependency = Gem::Dependency.new(gem_name, Gem::Requirement.default)
    download_gem Gem::SpecFetcher.fetcher().fetch(dependency)[0][0]
  end
  ffi_dependency = Gem::Dependency.new("ffi", Gem::Requirement.default)
  ffi_jruby_spec = Gem::SpecFetcher.fetcher().fetch(ffi_dependency, false, false).select{|s| s[0].platform.to_s == "java"}[0][0]
  download_gem ffi_jruby_spec
end

def clone(project_name)
  FileUtils.rm_rf project_name.to_s if File.exist?(project_name.to_s)
  print "Cloning #{project_name} ... "
  $stdout.flush
  Git.clone(@clone_urls[project_name], project_name.to_s, :path => '.')
  puts "done"
end

def is_cloned?(project_name)
  Git.open(project_name.to_s) rescue false
end


task :check_all do
  @clone_urls.each_key do |project|
    is_cloned?(project) ? puts('Found ' + project.to_s) : clone(project)
  end
end

#task :ruby_processing_gem do
#
#  Rake::Task[:check_all].invoke
#
##  g.branch("master").checkout
##  g.pull
##  if g.branches.local.map{|branch| branch.to_s}.include? "additional_gems"
#end

task :default =>:check_all