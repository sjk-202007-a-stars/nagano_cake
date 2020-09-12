class AdminController < ApplicationController
  before_action :authenticate_admin!
	def top
		@order = Order.where(created_at: Time.zone.now.all_day)
	end
end
