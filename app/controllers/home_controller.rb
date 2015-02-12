class HomeController < ApplicationController

	def index

		#@new_trailers = Array.new
		@movies = Tmdb::Movie.now_playing

		#movies.each do |movie|
			#@img = Tmdb::Movie.detail(movie.name)
			#@new_trailers.push(@img)
		#end 

		#movieUser = MoviesUsers.new()
		#movieUser.add_watch(id_movie, id_user, action) #[movie, movie2]
		#current_user.save

	end

end