class MoviesController < ApplicationController
	
	def home

		@new_trailers = Array.new
		movies = Tmdb::Movie.now_playing

		movies.each do |movie|
			@img = Tmdb::Movie.detail(movie.id)
			@new_trailers.push(@img)
		end 
	
	end

	def get_trailers
		return Tmdb::Movie.trailers(movieid)
	end
	
end
