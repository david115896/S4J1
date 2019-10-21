require 'gossip'

class ApplicationController < Sinatra::Base   #herite de la classe Sinatra
  
	get '/' do   #affiche index et affiche la liste de tous les gossips en appelant Gossip.all
		erb :index, locals: {gossips: Gossip.all}
	end

	get '/gossips/new/'  do	   #affiche le formulaire pour creer un gossip
		erb :new_gossip
	end

	post '/gossips/new/' do		#realise la sauvegarde d'un nouveau gossip et redirecte vers index
		Gossip.new(params).save
		redirec '/'
	end
  
	post '/gossip/modify/' do	#modifie un gossip dans la DB et redirecte vers index
		Gossip.modify(params)
		redirect '/' 
	end

	post '/comment/save/' do	#realise la sauvegarde d'un nouveau commentaire et redirecte vers la page du gossip 
		Comments.new(params).save
		erb :show_gossip, locals: {gossip: Gossip.find(params["gossip_index"])}
	end

	get '/comment/new/:index' do	#affiche le formulaire pour creer un nouveau commentaire et envoie l'index du gossip lie
		erb :new_comments, locals: {comment: params[:index]}	
	end

	get '/modify_gossip/:index' do		#affiche le formulaire pour modifier un gossip et envoie l'index du gossip souhaite	
		erb :modify_gossip, locals: {gossip: Gossip.find(params[:index])}
	end
  
	get '/show_gossip/:index' do		#affiche la page d'un gossip specifique
		erb :show_gossip, locals: {gossip: Gossip.find(params[:index])}
	end
end
