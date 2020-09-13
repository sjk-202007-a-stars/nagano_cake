class Admin::EndUsersController < Admin::Base

  def index
  	@end_users = EndUser.page(params[:page]).per(10)
  end

  def show
  	@end_user = EndUser.find(params[:id])
  end
  
  def edit
  	@end_user = EndUser.find(params[:id])
  end

  def update
  	@end_user = EndUser.find(params[:id])
	if @end_user.update(end_user_params)
		redirect_to admin_end_user_path(@end_user)
	else
	 render 'edit'
	end
  end

  private
  	def end_user_params
      params.require(:end_user).permit(:family_name, :first_name, :family_name_kana, :first_name_kana, :email, :postal_code, :address, :phone_number, :is_deleted)
  	end
end
