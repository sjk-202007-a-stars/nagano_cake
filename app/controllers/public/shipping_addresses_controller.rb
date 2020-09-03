class Public::ShippingAddressesController < Public::Base
  def index
    # @end_user = current_end_user
    # @shipping_addresses = ShippingAddresses.find_by(current_end_user.id)
    @shipping_addresses = ShippingAddress.all
    shipping_addresses = @shipping_addresses
    @myshipping_addresses = current_end_user.shipping_addresses
    @shipping_address = ShippingAddress.new
  end

  def create
    @shipping_address = ShippingAddress.new(shipping_address_params)
    @shipping_address.end_user_id = current_end_user.id
    if @shipping_address.save
      redirect_to shipping_addresses_path
    else
    	@shipping_addresses = ShippingAddress.all
      shipping_addresses = @shipping_addresses
      @myshipping_addresses = current_end_user.shipping_addresses
      @shipping_address = ShippingAddress.new
      render :index
    end
  end

  def edit
    @shipping_address = ShippingAddress.find(params[:id])
  end

  def update
  	shipping_address = ShippingAddress.find(params[:id])
    if shipping_address.update(shipping_address_params)
      redirect_to shipping_addresses_path
    else
    	@shipping_address = ShippingAddress.find(params[:id])
      render :edit
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