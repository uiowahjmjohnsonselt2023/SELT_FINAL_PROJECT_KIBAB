class ShoppingCart < ActiveRecord::Base
  belongs_to :user
  belongs_to :product
  def self.purchase_confirm(user_id,wallet_params)
    current_wallet = Wallet.find_by_user_id(user_id)
    total_price = 0
    cart_list = ShoppingCart.where(user_id: user_id)
    cart_list.each do |item|
      item.product.set_sold_true
      Purchase.create!(user_id: user_id, product_id: item.product.id, purchase_timestamp: Time.now)
      total_price += item.product.price.to_f
      user_selling = User.where(id: item.product.user_id).first
      user_wallet = Wallet.find_by_user_id(user_selling.id)
      user_wallet.update(wallet: user_wallet.wallet + item.product.transaction.to_f)
      ShoppingCart.destroy(item.id)
    end
    if wallet_params == 'on'
      if current_wallet.wallet > total_price
        current_wallet.wallet = current_wallet.wallet - total_price
      else
        current_wallet.wallet = 0
      end
      current_wallet.save
    end
    cart_list
  end

  def self.total_price(user_id,params)
    cart_list = ShoppingCart.where(user_id: user_id)
    current_wallet = Wallet.find_by_user_id(user_id).wallet
    total_price = 0
    cart_list.each do |item|
      total_price += item.product.price.to_f
    end
    if params == 'on'
      if current_wallet > total_price
        total_price = 0
      else
        total_price = @total_price - current_wallet
      end
    end
    total_price
  end
end
