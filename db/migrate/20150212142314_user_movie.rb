class UserMovie < ActiveRecord::Migration
	def change
		drop_table :movies_users
		
		create_table :movies_users do |um|
			um.integer :user_id, :null => false
			um.integer :movie_id, :null => false
			um.integer :etat, :null => false
			um.timestamps
		end
	end
end
