class Public::ShippingAddressesController < Public::Base
  def index
    @end_user = current_end_user
    # @shipping_addresses = @end_user.shipping_address
    @shipping_addresses = ShippingAddress.all
    @shipping_address = ShippingAddress.new
  end

  def create
    @shipping_address = ShippingAddress.new(shipping_address_params)
    @shipping_address._id = current_end_user.id
    @shipping_address.save
    redirect_to shipping_addresses_path
  end

  def edit

  end

  def update

  end

  def destroy

  end

  private
  def shipping_address_params
    params.require(:shipping_address).permit(:postal_code, :address, :name)
  end
end