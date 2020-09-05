class Public::EndUsersController < Public::Base
<<<<<<< HEAD
  def show
    @end_user = current_end_user
  end

  def edit
    @end_user = current_end_user
  end

  def update
  	@end_user = current_end_user
  	if @end_user.update(end_user_params)
  	redirect_to end_user_path
  	else
  		render 'edit'
  	end
  end

  private
  def end_user_params
   	params.require(:end_user).permit(:family_name, :first_name, :family_name_kana, :first_name_kana, :email, :postal_code, :address, :phone_number, :is_deleted)
  end
end
