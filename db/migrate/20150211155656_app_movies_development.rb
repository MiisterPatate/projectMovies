class AppMoviesDevelopment < ActiveRecord::Migration
  def change
  		change_table :movies do |m|
			m.integer :api_id, :null => false
		end
  end
end
