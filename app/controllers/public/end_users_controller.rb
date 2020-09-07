class Public::EndUsersController < Public::Base
  private
  def end_user_params
   	params.require(:end_user).permit(:family_name, :first_name, :family_name_kana, :first_name_kana, :email, :postal_code, :address, :phone_number, :is_deleted)
  end
end
