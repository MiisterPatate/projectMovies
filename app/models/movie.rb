class Movie < ActiveRecord::Base
	
	has_many :movies_users
  	has_many :users, through: :movies_users

end