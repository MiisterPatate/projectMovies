class HomeController < ApplicationController

	# Liste des films sur la page d'accueil
	def index
		@movies = Tmdb::Movie.now_playing
	end

end