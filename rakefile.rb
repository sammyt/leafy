require 'rubygems'
require 'bundler'
require 'bundler/setup'

require 'rake/clean'
require 'flashsdk'
require 'asunit4'

##
# Set USE_FCSH to true in order to use FCSH for all compile tasks.
#
# You can also set this value by calling the :fcsh task 
# manually like:
#
#   rake fcsh run
#
# These values can also be sent from the command line like:
#
#   rake run FCSH_PKG_NAME=flex3
#
# ENV['USE_FCSH']         = true
# ENV['FCSH_PKG_NAME']    = 'flex4'
# ENV['FCSH_PKG_VERSION'] = '1.0.14.pre'
# ENV['FCSH_PORT']        = 12321

##############################
# Debug

# Compile the debug swf
mxmlc "bin/Leafy-debug.swf" do |t|
  t.input = "src/Leafy.as"
  t.debug = true
end

desc "Compile and run the debug swf"
flashplayer :run => "bin/Leafy-debug.swf"

##############################
# Test

library :asunit4

# Compile the test swf
mxmlc "bin/Leafy-test.swf" => :asunit4 do |t|
  t.input = "src/LeafyRunner.as"
  t.source_path << 'test'
  t.library_path << 'lib/hamcrest/hamcrest-as3-only-1.1.3.swc'
  t.debug = true
end

desc "Compile and run the test swf"
flashplayer :test => "bin/Leafy-test.swf"

##############################
# SWC

compc "bin/Leafy.swc" do |t|
  t.input_class = "Leafy"
  t.source_path << 'src'
  t.include_sources << 'src/leafy'
end

desc "Compile the SWC file"
task :swc => 'bin/Leafy.swc'

##############################
# DOC

desc "Generate documentation at doc/"
asdoc 'doc' do |t|
  t.doc_sources << "src"
  t.exclude_sources << "src/LeafyRunner.as"
end

##############################
# DEFAULT
task :default => :run

