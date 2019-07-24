class ItemsController < ApplicationController

  def new
    @item = Item.new
  end

  def update
    @user = User.new
  end

  def create
  end


#   private
#
#   # def item_params
#   #   @item_number_list.each do |item_number|
#   #   params.require(item_number).permit(:item_number, :item_image, :item_url, :item_price)
#   #   end
#   # end
# end
