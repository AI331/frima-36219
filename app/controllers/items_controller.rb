class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit]
  before_action :set_item, only: [:show, :edit, :update]
  before_action :move_to_index, only: [:edit, :update, :destroy]
  before_action :sold_out_item, only: [:edit, :update]

  def index
    @items = Item.includes(:user).order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to action: :index
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to action: :index
    else
      render :edit
    end
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    redirect_to action: :index
  end

  private

  def item_params
    params.require(:item).permit(:image, :product_name, :description, :price, :category_id, :status_id, :burden_id, :delivery_id,
                                 :days_delivery_id).merge(user_id: current_user.id)
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in? && @item.user.id == current_user.id
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def sold_out_item
    redirect_to action: :index if @item.purchase.present?
  end
end
