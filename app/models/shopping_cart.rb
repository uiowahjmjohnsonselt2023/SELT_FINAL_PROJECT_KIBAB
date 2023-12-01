class ShoppingCart < ActiveRecord::Base
  belongs_to :user
  belongs_to :product
  def purchase_confirm(user_id,wallet_params)
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
end
