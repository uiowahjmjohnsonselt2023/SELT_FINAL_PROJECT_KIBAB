class ShoppingCartController < ApplicationController

  before_action :set_current_user

  def shopping_cart_params
    params.permit(:id, :use_wallet_balance, :user_id, :product_id,address: [:city,:state,:zip,:street_address], credit_card: [:credit_card_name,:credit_card_number,:credit_card_security_num,:credit_card_expiration])
  end

  def index
    ShoppingCart.where(user_id: @current_user.id).each do |item|
      if item.product.is_sold.eql? true
          flash[:notice] = "#{item.product.name} was sold."
          ShoppingCart.destroy(item)
      end
    end
    @current_shopping_cart_list = ShoppingCart.where(user_id: @current_user.id)
    @wallet = Wallet.where(user_id: @current_user.id).first
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
    if shopping_cart_params[:use_wallet_balance] == 'on'
      if current_wallet > @total_price
        @total_price = 0
      else
        @total_price = @total_price - current_wallet
      end
    end
    @total_price
  end

  def confirm_purchase
    if !shopping_cart_params[:address][:city].empty? && !shopping_cart_params[:address][:state].empty? &&!shopping_cart_params[:address][:street_address].empty? &&!shopping_cart_params[:address][:zip].empty?
      @lookup = Purchase.valid_address(shopping_cart_params[:address][:city],shopping_cart_params[:address][:state],shopping_cart_params[:address][:street_address],shopping_cart_params[:address][:zip])
      @valid_card = Wallet.check_credit(shopping_cart_params[:credit_card][:credit_card_name],shopping_cart_params[:credit_card][:credit_card_number],shopping_cart_params[:credit_card][:credit_card_security_num],shopping_cart_params[:credit_card][:credit_card_expiration])
      if @lookup.is_a?(Hash) && @valid_card == ''
        current_wallet = Wallet.find_by_user_id(@current_user.id)
        total_price = 0
        @current_shopping_cart_list = ShoppingCart.where(user_id: @current_user.id)
        @current_shopping_cart_list.each do |item|
          item.product.set_sold_true
          Purchase.create!(user_id: @current_user.id, product_id: item.product.id, purchase_timestamp: Time.now)
          total_price += item.product.price.to_f
          user_selling = User.where(id: item.product.user_id).first
          user_wallet = Wallet.find_by_user_id(user_selling.id)
          user_wallet.update(wallet: user_wallet.wallet + item.product.transaction.to_f)
          ShoppingCart.destroy(item.id)
        end

        if shopping_cart_params[:use_wallet_balance] == 'on'
          if current_wallet.wallet > total_price
            current_wallet.wallet = current_wallet.wallet - total_price
          else
            current_wallet.wallet = 0
          end
          current_wallet.save
        end

        flash[:notice] = "Purchased successfully!"
        redirect_to products_path
      elsif @lookup.is_a?(String)
        flash[:notice] = 'Error' + @lookup
        render checkout_path
      elsif @valid_card != ''
        flash[:notice] = @valid_card
        render checkout_path
      else
        flash[:notice] = 'Not a valid address'
        render checkout_path
      end
    else
      flash[:notice] = 'Please fill in every address box'
      render checkout_path
    end

  end

  def delete_one
    if bookmark_params[:id].present?
      @shopping_cart_item = shopping_cart_params[:id]
      ShoppingCart.destroy(@shopping_cart_item)
      flash[:notice] = "Item deleted from shopping cart."
      redirect_to view_shopping_cart_path
    else
      flash[:notice] = "Could not delete #{@shopping_cart_item.product.name}."
    end
  end
end
