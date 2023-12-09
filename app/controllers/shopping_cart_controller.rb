class ShoppingCartController < ApplicationController

  before_action :set_current_user
  before_action :set_current_shopping_cart


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
    use_wallet = shopping_cart_params[:use_wallet_balance] == 'on'
    @total_price = ShoppingCart::compute_total_price(@current_shopping_cart_list, current_wallet, use_wallet)
  end

  def confirm_purchase
    @current_shopping_cart_list = ShoppingCart.where(user_id: @current_user.id)
    current_wallet = Wallet.find_by_user_id(@current_user.id).wallet
    use_wallet = shopping_cart_params[:use_wallet_balance] == 'on'
    @total_price = ShoppingCart::compute_total_price(@current_shopping_cart_list, current_wallet, use_wallet)

    if !shopping_cart_params[:address][:city].empty? && !shopping_cart_params[:address][:state].empty? &&!shopping_cart_params[:address][:street_address].empty? &&!shopping_cart_params[:address][:zip].empty?
      @lookup = Purchase.valid_address(shopping_cart_params[:address][:city],shopping_cart_params[:address][:state],shopping_cart_params[:address][:street_address],shopping_cart_params[:address][:zip])
      if @total_price.to_f > 0.00
        @valid_card = Wallet.check_credit(shopping_cart_params[:credit_card][:credit_card_name],shopping_cart_params[:credit_card][:credit_card_number],shopping_cart_params[:credit_card][:credit_card_security_num],shopping_cart_params[:credit_card][:credit_card_expiration])
      else
        @valid_card = ''
      end

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
          ShoppingCart::update_wallet(current_wallet, total_price)
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

  def destroy_all
    ShoppingCart.where(user_id: @current_user.id).destroy_all
    flash[:notice] = "Shopping Cart Cleared!"
    redirect_to view_shopping_cart_path
  end
end
