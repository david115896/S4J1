require 'comments'

class Gossip   		#classe qui permet de faire la connexion entre le controller, la classe Comments et les BD
	attr_accessor :author, :content, :index, :comments

	def initialize(params)		
		if params[:author] == nil	#si la key author est nil c'est que la demande vient d'un formulaire
			@author=params["gossip_author"]	
			@content=params["gossip_content"]
                        @index = Gossip.csv_size + 1
		else			#sinon la demande de self.all
			@author = params[:author]
			@content = params[:content]
		        @index = params[:index]
		end
		@comments = Comments.show_comments(@index)		#on cree un array ou sont l'ensemble des commentaires lies a l'index du gossip
	end

	def self.csv_size		#calcul le nombre de ligne du tableau CSV
		if File.exist?('db/gossip.csv') == false	#creer le tableau si celui n'existe pas encore
                        CSV.open('db/gossip.csv', 'a') do |csv|
                        csv << ["Index", "Authors", "Contents"]
                        end
                end
		CSV.read('db/gossip.csv', headers: true, header_converters: :symbol, converters: :all).size
	end

	def self.modify(params)		#def pour modifier un gossip
		file = Gossip.all	#utilise la def self.all  pour recuper toutes les instances Gossip
                CSV.open('db/gossip.csv', 'w') do |csv|
	                csv << ["Index", "Authors", "Contents"]
			file.each do |row|
				if row.index.to_s == params["gossip_index"].to_s    #recherche le gossip qui correspond a l'index souhaite
					csv.puts [params["gossip_index"], params["gossip_author"], params["gossip_content"]]   #modifie la ligne qui correspond a l'index avec les infos du formulaires
				else
					csv << [row.index, row.author, row. content]   	#sinon recopie les lignes deja presentes
				end
			end
                end
	end

	def save		#methode qui sauvegarde un nouveau gossip
		if File.exist?('db/gossip.csv') == false
			CSV.open('db/gossip.csv', 'a') do |csv|
                        csv << ["Index", "Authors", "Contents"]  
	  		end
		end
		CSV.open('db/gossip.csv', 'a') do |csv|
        		csv << [@index, @author, @content]
      		end
  	end

	def self.find(index)		#methode qui cherche l'instance du gossip qui correspond a l'index souhaite
		gossip_founded = ""		
		Gossip.all.each do |gossip|		#utilise la fonction self.all pour boucler sur l'ensemble des instances de Gossip
			if gossip.index.to_s == index.to_s
				gossip_founded = gossip
			end
		end

		return gossip_founded
	end


	def self.delete(index)    #methode qui permet de supprimer une ligne du CSV selon l'index demande. 

		file = CSV.read('db/gossip.csv', headers: true, header_converters: :symbol, converters: :all) 
		file.delete(index) 
		CSV.open('db/gossip.csv', 'w') do |csv|
                        csv << ["Index", "Authors", "Contents"]
			file.each do |row|
				csv.puts row
			end
		end
	end
	

	def self.all		#methode qui cree un array de toutes les instances de Gossip qui represente les lignes de la DB gossip.csv
		all_gossips = Array.new
		if File.exist?('db/gossip.csv') == true
			file = CSV.read('db/gossip.csv', headers: true, header_converters: :symbol, converters: :all)
			file.each do |row|
				params = {index: row[:index], author: row[:authors], content: row[:contents]}
				all_gossips <<  Gossip.new(params)		
			end
		end	
		return all_gossips
	end

end
