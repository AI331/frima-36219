class ItemsController < ApplicationController
  def index
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(message_params)
    if @item.save
      redirect_to :index
    else
      render :new
    end
  end


private

def message_params
  params.require(:message).permit(:image).merge(user_id: current_user.id)
end
end
