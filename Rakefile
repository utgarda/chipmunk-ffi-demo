require 'rubygems'
require 'fileutils'
require 'git'


@clone_urls = {:ruby_processing => 'git://github.com/jashkenas/ruby-processing.git',
               :jruby => 'git://github.com/jruby/jruby.git',
               :chipmunk_ffi =>'git://github.com/shawn42/chipmunk-ffi.git',
               :nice_ffi => 'git://github.com/jacius/nice-ffi.git',
               :ffi_jruby =>'git://github.com/ffi/ffi-jruby.git'}

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