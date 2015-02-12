class MoviesUsersController < ApplicationController

	# Action "À voir" ou "Vu"
	def add_watch
		id_user = params[:user_id]
		id_movie = params[:movie_id]
		etat = params[:etat]

		#--- Ajout du film dans la table movies ---#
		movie = Movie.where(:api_id => id_movie) 
		if movie.empty? 
			detail_movie = Tmdb::Movie.detail(id_movie)

			movie = Movie.new(:title => detail_movie.title, :description => detail_movie.overview, :url_cover => detail_movie.poster_path, :api_id => id_movie)
			movie.save

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

	# Liste des films à voir ou vu
	def movies_list
		@movies_users_list = current_user.movies_users.where(:etat => 1)

		@movies_viewed = Array.new

		@movies_users_list.each do |movie|
			if movie
				@movies_viewed.push(Movie.where(:api_id => movie['movie_id']).first)
			end
		end


		@movies_users_list = current_user.movies_users.where(:etat => 2)

		@movies_to_see = Array.new

		@movies_users_list.each do |movie|
			if movie
				@movies_to_see.push(Movie.where(:api_id => movie['movie_id']).first)
			end
		end

	end

end
