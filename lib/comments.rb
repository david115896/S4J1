
class Comments		#Classe pour interagir avec la DB comments
        attr_accessor :index_gossip, :content, :author 

	def initialize(params)	
                if params[:author] == nil   #si la key author est vide c'est que nous utilisons un formulaire     
			@index_gossip=params["gossip_index"]
                	@content=params["comment_content"]
			@author=params["comment_author"]
        	else				#sinon les informations arrivent de show_comments
                        @author = params[:author]
                        @content = params[:content]
                        @index = params[:index]
                end
	end
	
	def save		#creer un commentaire ala fois
		 if File.exist?('db/comments.csv') == false	#verifie si le fichier DB existe, sinon il le cree
                        CSV.open('db/comments.csv', 'a') do |csv|
                        	csv << ["Index", "Authors", "Contents"]		#creation des titres du fichier CSV
                        end
                end
                CSV.open('db/comments.csv', 'a') do |csv|	#ajout du commentaire dans la DB 
                        csv << [@index_gossip, @author, @content]		
                end
	end

	def self.show_comments(index) 		#permet de retourner un array de tous les commentaires en rapport avec le gossip d'un index specifique 
		all_comments = Array.new
                if File.exist?('db/comments.csv') == true
	                file = CSV.read('db/comments.csv', headers: true, header_converters: :symbol, converters: :all)  #lis tous la DB
                	file.delete_if do |row|			#si l'index du commentaire ne correspond pas a l'index du gossip, on supprimer du FIle
				row[:index] != index.to_i
        		end
			file.each do |row|
				params = {index: row[:index], author: row[:authors], content: row[:contents]}
				all_comments << Comments.new(params)	#on ajouter toutes les commentaires de l'index en creant des instances pour retrouver facilement leurs informations
			end       
                end
                return all_comments #retourne un array avec les instances des commentaires de l'index
	end
end
