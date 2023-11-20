class ShoppingCartController < ApplicationController

  before_filter :set_current_user

  def index
    @current_shopping_cart_list = ShoppingCart.where(user_id: @current_user.id)
  end

  def edit
    # add later
  end

  def destroy
    # add later
  end

  def checkout
    @current_shopping_cart_list = ShoppingCart.where(user_id: @current_user.id)


    flash[:notice] = "Successfully made a purchase!"
  end

end
