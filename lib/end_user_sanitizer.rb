class EndUserParameterSanitizer < Devise::ParameterSanitizer
  def initialize(*)
    super
    permit(:sign_up, keys: [:family_name, :first_name, :family_name_kana, :first_name_kana,
                            :postal_code, :phone_number, :address, :email, :password, :password_confirmation])
  end
end