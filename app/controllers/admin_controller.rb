class AdminController < ApplicationController
	def top
		@order = Order.where(created_at: Time.zone.now.all_day)
	end
end
