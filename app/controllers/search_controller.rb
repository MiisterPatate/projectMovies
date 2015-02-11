class SearchController < ApplicationController
	def index
		@movie = Tmdb::Movie.find(params[:query])
	end
end