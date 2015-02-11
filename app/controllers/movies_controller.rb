class MoviesController < ApplicationController
	
	def home

		#@new_trailers = Array.new
		@movies = Tmdb::Movie.now_playing

		#movies.each do |movie|
			#@img = Tmdb::Movie.detail(movie.name)
			#@new_trailers.push(@img)
		#end 

		movie = Movie.where(:title => "anais") 
		if movie.empty? 
			movie = Movie.new(:title => "anais", :description => "Tataaaa", :url_cover => "fttto.com")
			movie.new_record?
			true
			movie.save
			true
			movie.new_record?
			false
		end
		current_user.movies << movie #[movie, movie2]
		current_user.save

	
	end


	def user_movie
		movie = Movie.where(:id => 1, :title => "toto", :description => "Tataaaa", :url_cover => "fttto.com")
		if movie
			# Le film est déjà en BDD
		else
			movie = Movie.new(:id => 1, :title => "toto", :description => "Tataaaa", :url_cover => "fttto.com")
			movie.new_record?
			true
			movie.save
			true
			movie.new_record?
			false
		end
		current_user.movie << movie #[movie, movie2]
		current_user.save
	end


	def get_trailers
		#return Tmdb::Movie.trailers(movieid)
	end
	
end
