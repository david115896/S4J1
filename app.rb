#My ruby file app
require 'bundler'
Bundler.require
$:.unshift File.expand_path('./../lib', __FILE__)
require 'app/application_controller'


get '/hello' do
	Controller
#	'<h1>Hello world ! </h1>'
end

#MyClass.new.perform
