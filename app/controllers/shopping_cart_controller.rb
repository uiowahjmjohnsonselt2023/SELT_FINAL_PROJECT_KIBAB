class ShoppingCartController < ApplicationController

  before_action :set_current_user

  def index
    @current_shopping_cart_list = ShoppingCart.where(user_id: @current_user.id)
    @wallet = Wallet.find_by_user_id(@current_user.id)
  end

  def edit
    # add later
  end

  def checkout
    @current_shopping_cart_list = ShoppingCart.where(user_id: @current_user.id)
    current_wallet = Wallet.find_by_user_id(@current_user.id).wallet
    @total_price = 0
    @current_shopping_cart_list.each do |item|
      @total_price += item.product.price.to_f
    end
    if params[:use_wallet_balance] == 'on'
      if current_wallet > @total_price
        @total_price = 0
      else
        @total_price = @total_price - current_wallet
      end
    end
    @total_price
  end

  def confirm_purchase
    current_wallet = Wallet.find_by_user_id(@current_user.id).wallet
    total_price = 0
    @current_shopping_cart_list = ShoppingCart.where(user_id: @current_user.id)
    @current_shopping_cart_list.each do |item|
      item.product.set_sold_true
      Purchase.create!(user_id: @current_user.id, product_id: item.product.id, purchase_timestamp: Time.now)
      total_price += item.product.price.to_f
      user_selling = User.where(id: item.product.user_id).first
      user_wallet = Wallet.find_by_user_id(user_selling.id)
      user_selling.update(wallet: user_wallet.wallet + item.product.transaction.to_f)
      ShoppingCart.destroy(item.id)
    end

    if params[:use_wallet_balance] == 'on'
      if current_wallet > total_price
        current_wallet = current_wallet - total_price
      else
        current_wallet = 0
      end
      current_wallet.save
    end

    flash[:notice] = "Purchased successfully!"
    redirect_to products_path
  end
end
