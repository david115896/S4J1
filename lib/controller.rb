require 'bundler'
Bundler.require
$:.unshift File.expand_path('./../lib', __FILE__)

require 'gossip'


class ApplicationController < Sinatra::Base
  attr_accessor :result
	get '/' do
	  erb :index, locals: {gossips: Gossip.all}
  end

  get '/gossips/new/'  do
	erb :new_gossip
  end


  post '/gossips/new/' do
	Gossip.new(params).save
  	 redirect '/'
  end
  
  post '/gossip/modify/' do
	  Gossip.modify(params)
	# erb :show_gossip, locals: {gossip: Gossip.find(params["gossip_index"])}
	redirect '/' 
  end

  post '/comment/new' do
	Comments.new(params).save
	erb :show_gossip, locals: {gossip: Gossip.find(params["gossip_index"])}

  end

  get '/comment/new/' do
	erb :new_comments
  end

  get '/modify_gossip/:index' do
	erb :modify_gossip, locals: {gossip: Gossip.find(params[:index])}
  end
  
  get '/show_gossip/:index' do
	erb :show_gossip, locals: {gossip: Gossip.find(params[:index])}
  end
 
end
