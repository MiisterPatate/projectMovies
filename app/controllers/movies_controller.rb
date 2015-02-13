class MoviesController < ApplicationController

	# Page du film
	def show
		# Détail du film
	  	@movie = Tmdb::Movie.detail(params[:id])

	  	# Bande annonce du film
	  	@trailers = Tmdb::Movie.trailers(params[:id])
  	end
	
end