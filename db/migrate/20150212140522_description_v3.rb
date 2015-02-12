class DescriptionV3 < ActiveRecord::Migration
  def change
  	change_table :movies do |m|
  			
	 	m.remove :description
	 	m.text :description, :null => true

	end
  end
end
