class SearchController < ApplicationController 
	def index 
		@services = Serivce.all.order('created_at DESC')
	end

	def search
		if params[:q]
			@services = Service.search(params[:q]).order("created_at DESC")
		else
			@services = Serivce.all.order('created_at DESC')
		end
	end
end