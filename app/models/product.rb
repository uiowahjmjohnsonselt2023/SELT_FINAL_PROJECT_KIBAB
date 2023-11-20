# frozen_string_literal: true

class Product < ActiveRecord::Base

  mount_uploader :image, ImageUploader

  belongs_to :user

  validates :name, presence: true, length: {maximum: 50}
  # validates :image, presence: true
  validates :category, presence: true, length: {maximum: 50}
  validates :description, presence: true
  #TODO: Fix regex expression controlling price, add validation location, description, and categories
  VALID_PRICE_REGEX = /\d+()|(.\d\d)/
  validates :price, presence: true, format: {with: VALID_PRICE_REGEX} # Regex for US dollar format
  validates :location, presence: true # Formatting may be needed in the future

  def transaction
    price = self.price.to_i
    if price < 10
      commission_price = price - (0.1 * price)
    else
      commission_price = price - (0.15 * price)
    end
    commission_price.to_s
  end
  def valid_price?
    price_regex = /\A\d+\.\d{2}\z/
    self.price.match?(price_regex)
  end

  def valid_description?
    ['Well Worn', 'Used', 'Like New', 'New'].include?(self.description)
  end

  def valid_category?
    ['Home', 'Entertainment', 'Clothing', 'Personal Care', 'Office', 'Other'].include?(self.category)
  end

  def valid_address?
    # TODO - implement proper address validation
    false
  end

  # Searches database for specified product name, can return multiple products
  def self.search_by_name(search)
    if search.present?
      @product = products.where("name=#{search}")
    else
      self
    end
  end

  # Searches database for specifies product category, can return multiple products
  def self.search_by_category(search)
    if search.present?
      @product = products.where("category=#{search}")
    else
      self
    end
  end

  def self.add_to_shopping_cart(user_id, product_id)
    var = ShoppingCart.where(user_id: user_id).where(product_id: product_id).present?
    if !var.present?
      shopping_cart_item = {:user_id => user_id, :product_id => product_id}
      ShoppingCart.create!(shopping_cart_item)
    end
  end

end
