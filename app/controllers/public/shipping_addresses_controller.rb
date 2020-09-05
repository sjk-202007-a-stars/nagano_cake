class Public::ShippingAddressesController < Public::Base
  def index
    @shipping_addresses = ShippingAddress.where(end_user_id: current_end_user.id)
    @shipping_address = ShippingAddress.new
  end

  def create
    @shipping_address = ShippingAddress.new(shipping_address_params)
    @shipping_address.end_user_id = current_end_user.id
    if @shipping_address.save
      redirect_to shipping_addresses_path
    else
      @shipping_addresses = ShippingAddress.where(end_user_id: current_end_user.id)
      render 'index'
    end
  end

  def edit
    @shipping_address = ShippingAddress.find(params[:id])
  end

  def update
  	@shipping_address = ShippingAddress.find(params[:id])
    if @shipping_address.update(shipping_address_params)
      redirect_to shipping_addresses_path
    else
      render 'edit'
    end
  end

  def destroy
  	shipping_address = ShippingAddress.find(params[:id])
  	shipping_address.destroy
  	redirect_to shipping_addresses_path
  end

  private
  def shipping_address_params
    params.require(:shipping_address).permit(:postal_code, :address, :name)
  end
end