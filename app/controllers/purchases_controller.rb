class PurchasesController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    @purchase_address = PurchaseAddress.new
  end

  def create
    @item = Item.find(params[:item_id])
    @purchase_address = PurchaseAddress.new(purchase_params)
    if @purchase_address.valid?
      Payjp.api_key = "sk_test_fd2a7700d8a84a5c61b3152f" 
      Payjp::Charge.create(
        amount: @item[:price], 
        card: purchase_params[:token], 
        currency: 'jpy'                 
      )
      @purchase_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def purchase_params
    params.require(:purchase_address).permit(:postal_code, :delivery_id, :municipality, :address, :building_name, :phone_number).merge(user_id: current_user.id, item_id: @item, token: params[:token])
  end

end
