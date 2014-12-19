class AppMoviesDevelopment < ActiveRecord::Migration
  
	def self.up
		create_table :users do |u|
			u.string :email, :null => false
			u.string :password, :null => false
			u.timestamps
		end

		create_table :movies do |m|
			m.string :title, :null => false
			m.text :description, :null => false
			m.text :url_cover, :null => false
			m.timestamps
		end

		create_join_table :users, :movies do |j|
			j.integer :user_id, :null => false
			j.integer :movie_id, :null => false
			j.integer :etat, :null => false #0: Rien, 1: "À voir", 2: Vu
			j.timestamps
		end
	end

end
