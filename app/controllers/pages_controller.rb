class PagesController < ApplicationController
	
	#Show complete list of 
	def home 
		 @tasks = Task.accessible_by(current_ability)
	end
end
