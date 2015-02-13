class SearchController < ApplicationController

	# Page de résultats de recherche
	def index
		@movies = Tmdb::Movie.find(params[:query])
	end

end