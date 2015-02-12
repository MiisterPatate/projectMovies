class MoviesController < ApplicationController

	def show
	  	@movie = Tmdb::Movie.detail(params[:id])
	  	@images = Tmdb::Movie.images(params[:id])
	  	@cast = Tmdb::Movie.casts(params[:id])
	  	@trailers = Tmdb::Movie.trailers(params[:id])
  		@similar_movies = Tmdb::Movie.similar_movies(params[:id])
  	end
	
	def home

		#@new_trailers = Array.new
		@movies = Tmdb::Movie.now_playing

		#movies.each do |movie|
			#@img = Tmdb::Movie.detail(movie.name)
			#@new_trailers.push(@img)
		#end 

	end

	def get_trailers
		#return Tmdb::Movie.trailers(movieid)
	end
	
end
