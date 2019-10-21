require 'bundler'
Bundler.require
$:.unshift File.expand_path('./../lib', __FILE__)


class Comments

        attr_accessor :index_gossip, :content, :author
        def initialize(params)
                        
		@index_gossip=params["gossip_index"]
                @content=params["comment_content"]
		@author=params["comment_author"]
        end
	

	def save
		 if File.exist?('db/comments.csv') == false
                        CSV.open('db/comments.csv', 'a') do |csv|
                        csv << ["Index", "Authors", "Contents"]
                        end
                end
                CSV.open('db/comments.csv', 'a') do |csv|
                        csv << [@index_gossip, @author, @content]
                        
                end

	end


	def show_comments
		all_comments = Array.new
                if File.exist?('db/comments.csv') == true

                file = CSV.read('db/comments.csv', headers: true, header_converters: :symbol, converters: :all)
                	
			file.delete_if do |row|
	               		row[:index] == @index_gossip
        		end
			
			file.each do |row|
				all_comments << row
			end
		               
                end

                return all_comments
	
	end

end
