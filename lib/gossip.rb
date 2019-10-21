require 'bundler'
Bundler.require
$:.unshift File.expand_path('./../lib', __FILE__)


class Gossip

	attr_accessor :author, :content, :index
	def initialize(params)
		if params[:author] == nil
			@author=params["gossip_author"]	
			@content=params["gossip_content"]
                        @index = Gossip.csv_size + 1
		else
			@author = params[:author]
			@content = params[:content]
		        @index = params[:index]
		end
	end

	def self.csv_size
		if File.exist?('db/gossip.csv') == false
                        CSV.open('db/gossip.csv', 'a') do |csv|
                        csv << ["Index", "Authors", "Contents"]
                        end
                end
 
		CSV.read('db/gossip.csv', headers: true, header_converters: :symbol, converters: :all).size

	end

	def self.modify(params)
		file = Gossip.all
                CSV.open('db/gossip.csv', 'w') do |csv|
	                csv << ["Index", "Authors", "Contents"]

			file.each do |row|
				if row.index.to_s == params["gossip_index"].to_s 
					
					csv.puts [params["gossip_index"], params["gossip_author"], params["gossip_content"]]
					#csv[2] = params["gossip_content"
				else
				csv << [row.index, row.author, row. content]
				end
			end
                end

	end

	def save
		if File.exist?('db/gossip.csv') == false
			CSV.open('db/gossip.csv', 'a') do |csv|
                        csv << ["Index", "Authors", "Contents"]  
	  		end
		end
		CSV.open('db/gossip.csv', 'a') do |csv|
        		csv << [@index, @author, @content]
      		end
  	end


	def add_comment
		Comments.new()
	end
	
	def self.find(index)
		gossip_founded = ""
		Gossip.all.each do |gossip|
			if gossip.index.to_s == index.to_s
				gossip_founded = gossip
			end
		end
		return gossip_founded
	end


	def self.delete(index)

		file = CSV.read('db/gossip.csv', headers: true, header_converters: :symbol, converters: :all) 
		file.delete(index)   #supprime une ligne du tabeau par son index
		#file.delete(:authors)	#supprime une colonne du tableau par son titre
		#file.delete_if do |row| #supprime chaque ou l'auteur se nomme David
		#	row[:authors] =="David"
		#end 
		CSV.open('db/gossip.csv', 'w') do |csv|
                        csv << ["Index", "Authors", "Contents"]
			file.each do |row|
				csv.puts row
			end
		end
	
	end
	

	def self.all
		all_gossips = Array.new
		if File.exist?('db/gossip.csv') == true

		file = CSV.read('db/gossip.csv', headers: true, header_converters: :symbol, converters: :all)
		file.each do |row|
			
			params = {index: row[:index], author: row[:authors], content: row[:contents]}
			all_gossips <<  Gossip.new(params)		
		end
		
		else
		
			puts "le fichier n'existe pas! Commence par ecrire un potin"
		end	

		return all_gossips


		#headers: true # Removes headers from read
		#header_converters: :symbol # Allows each header to be accessed by their respective symbol
		#converters: :all # Converts each datatype to the correct ruby datatype ex: string representations of integers get converted into intege
	end



end
