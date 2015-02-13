class MoviesUsersController < ApplicationController

	# ***************************** #
	# 	1. Action "À voir" ou "Vu" 
	#
	# ***************************** #
	def add_watch
		# Récupération des ID de l'user connecté et de la movie ainsi que l'état "À voir" ou "Vu"
		id_user = params[:user_id]
		id_movie = params[:movie_id]
		etat = params[:etat] # Dans la base de donnée, état 1 : Vu - état 2 : À voir


		# ***************************** #
		# 	1.1 Ajout du film dans la table movies
		#
		# ***************************** #
		movie = Movie.where(:api_id => id_movie) # Vérifie si le film n'existe pas déjà en BDD
		
		if movie.empty? 
			# Récupère les données du film dans l'API
			detail_movie = Tmdb::Movie.detail(id_movie)

			# Enregistre le film dans la table movies
			movie = Movie.new(
				:title => detail_movie.title,
				:description => detail_movie.overview,
				:url_cover => detail_movie.poster_path,
				:api_id => id_movie
			)

			movie.save
		end


		# ***************************** #
		# 	1.2 Ajout d'une relation entre movies et users
		#
		# ***************************** #
		# Vérifie si le film n'est pas déjà lié à l'utilisateur courant dans la table movies_users
		user_movie = current_user.movies_users.where(:movie_id => id_movie).first
		
		# Même vérification qu'au dessus + si l'état du film correspond à l'état qu'on lui demande d'avoir
		# Afin d'éviter des doublons
		user_movie_etat = current_user.movies_users.where(:movie_id => id_movie, :etat => etat)
		
		# Si le film n'est pas lié à l'utilisateur courant
		if user_movie.nil?

			# Enregistre la relation entre le film  et l'utilisateur dans la table movies_users
			user_movie = MoviesUser.new(
				:user_id => id_user,
				:movie_id => id_movie,
				:etat => etat
			)

			user_movie.save
		
		# Si le film est lié à l'utilisateur mais que l'état qu'on lui demande d'avoir est différent de celui qui est déjà enregistré
		# Par exemple l'état actuel est "À voir" et l'utilisateur clique sur "Vu"
		elsif user_movie_etat.empty?

			# On met à jour le nouvel état
			user_movie.update_attributes( etat: etat )

		end

		# On redirige
		redirect_to "/movies/"+id_movie

	end

	# Liste des films à voir ou vu
	def movies_list
		# Liste des films liés à l'utilisateur courant (table movies_users)
		# Order by À voir puis Vu
		@movies_users = current_user.movies_users.order("etat DESC")

		# Liste des films
		@movies = Array.new

		@movies_users.each do |movie|
			if movie
				
				# Récupère la liste des films dans la table movies
				@movies.push(Movie.where(:api_id => movie['movie_id']).first)
				
			end
		end

	end

end
