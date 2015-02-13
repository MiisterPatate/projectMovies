class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
	     :recoverable, :rememberable, :trackable, :validatable

	has_many :movies_users
	has_many :movies, through: :movies_users

	def get_user_movie(movie)
		# Self : user
		# Renvoie une liste de users_movies liée à l'utilisateur courant
		self.movies_users.where(:movie_id => movie.api_id).first
	end
end
