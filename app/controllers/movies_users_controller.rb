class MoviesUsersController < ApplicationController

	def add_watch
		id_user = params[:user_id]
		id_movie = params[:movie_id]
		etat = params[:etat]

		#--- Ajout du film dans la table movies ---#
		movie = Movie.where(:api_id => id_movie) 
		if movie.empty? 
			detail_movie = Tmdb::Movie.detail(id_movie)

			movie = Movie.new(:title => detail_movie.title, :description => detail_movie.overview, :url_cover => detail_movie.poster_path, :api_id => id_movie)
			movie.new_record?
			true
			movie.save
			true
			movie.new_record?
			false
		end

		#--- Ajout d'une relation entre movies et users ---#
		# Test si on trouve une ligne avec l'user courant + l'id de la movie
		user_movie = current_user.movies_users.where(:movie_id => id_movie).first
		
		# Test comme ci-dessous avec l'état en +. Pour passer l'état de "A voir" à "Vu"
		user_movie_etat = current_user.movies_users.where(:movie_id => id_movie, :etat => etat)
		
		if user_movie.nil?

			user_movie = MoviesUser.new(:user_id => id_user, :movie_id => id_movie, :etat => etat)
			user_movie.save
			
		elsif user_movie_etat.empty?

			user_movie.update_attributes( etat: etat )

		end

		redirect_to "/"

	end

end
