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

  post '/comment/save/' do
	Comments.new(params).save
	erb :show_gossip, locals: {gossip: Gossip.find(params["gossip_index"])}

  end

  get '/comment/new/:index' do
	erb :new_comments, locals: {comment: params[:index]}
  end

  get '/modify_gossip/:index' do
	erb :modify_gossip, locals: {gossip: Gossip.find(params[:index])}
  end
  
  get '/show_gossip/:index' do
	erb :show_gossip, locals: {gossip: Gossip.find(params[:index])}
  end
 
end
