class PurchasesController < ApplicationController
  before_action :set_item, only: [:index, :sold_out_item]
  before_action :sold_out_item, only: [:index]

  def index
    @purchase_address = PurchaseAddress.new
  end

  def create
    @item = Item.find(params[:item_id])
    @purchase_address = PurchaseAddress.new(purchase_params)
    if @purchase_address.valid?
      Payjp.api_key = ENV['PAYJP_SECRET_KEY']
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
    params.require(:purchase_address).permit(:postal_code, :delivery_id, :municipality, :address, :building_name, :phone_number).merge(
      user_id: current_user.id, item_id: @item, token: params[:token]
    )
  end

  def sold_out_item
    redirect_to root_path if @item.purchase.present?
  end

  def set_item
    @item = Item.find(params[:item_id])
  end
end
