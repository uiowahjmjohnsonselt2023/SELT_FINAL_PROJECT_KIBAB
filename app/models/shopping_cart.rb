class ShoppingCart < ActiveRecord::Base
  belongs_to :user
  belongs_to :product

  def self.compute_total_price(shopping_cart_list, current_wallet, use_wallet)
    total_price = 0
    shopping_cart_list.each do |item|
      total_price += item.product.price.to_f
    end
    total_price = sprintf("%.2f", total_price)
    if use_wallet
      if current_wallet > total_price.to_f
        total_price = 0
      else
        total_price = total_price.to_f - current_wallet
      end
    end
    sprintf("%.2f", total_price)
  end
end
