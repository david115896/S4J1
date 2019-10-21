
class Comments

        attr_accessor :index_gossip, :content, :author
        def initialize(params)
                if params[:author] == nil        
			@index_gossip=params["gossip_index"]
                	@content=params["comment_content"]
			@author=params["comment_author"]
        	else
                        @author = params[:author]
                        @content = params[:content]
                        @index = params[:index]
                end

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


	def self.show_comments(index)
		all_comments = Array.new
                if File.exist?('db/comments.csv') == true

                file = CSV.read('db/comments.csv', headers: true, header_converters: :symbol, converters: :all)
                	
			file.delete_if do |row|
				row[:index] != index.to_i
        		end
			
			file.each do |row|
				params = {index: row[:index], author: row[:authors], content: row[:contents]}
				all_comments << Comments.new(params)
			end
		               
                end

                return all_comments
	
	end

end
