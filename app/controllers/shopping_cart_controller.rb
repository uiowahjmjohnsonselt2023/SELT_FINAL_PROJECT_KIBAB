class ShoppingCartController < ApplicationController

  before_action :set_current_user

  def index
    @current_shopping_cart_list = ShoppingCart.where(user_id: @current_user.id)
  end

  def edit
    # add later
  end

  def checkout
    # left empty
  end

  def confirm_purchase
    current_wallet = @current_user.wallet
    @current_shopping_cart_list = ShoppingCart.where(user_id: @current_user.id)
    @current_shopping_cart_list.each do |item|
      item.product.set_sold_true
      Purchase.create!(user_id: @current_user.id, product_id: item.product.id, purchase_timestamp: Time.now)
      current_wallet = current_wallet - item.product.price.to_f
      user_selling = User.where(id: item.product.user_id).first
      user_selling.update(wallet: user_selling.wallet + item.product.price.to_f)
      ShoppingCart.destroy(item.id)
    end
    @current_user.update(wallet: current_wallet)
    flash[:notice] = "Purchased successfully!"
    redirect_to products_path
  end
end
