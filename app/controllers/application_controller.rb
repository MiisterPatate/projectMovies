class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
 	protect_from_forgery
  	require 'themoviedb'

	before_filter :set_config


	def set_config
		@configuration = Tmdb::Configuration.new

	end

end
