# Require gems and classes
require 'bundler'
Bundler.require
$: << File.expand_path('../', __FILE__)
Dir['./app/**/*.rb'].sort.each { |file| require file }

# Configure sinatra
set :root, Dir['./app']
set :public_folder, Proc.new { File.join(root, 'assets') }
set layout_options: { views: 'views/layouts' }
