# frozen_string_literal: true

class Product < ActiveRecord::Base

  mount_uploader :image, ImageUploader

  belongs_to :user

  validates :name, presence: true, length: {maximum: 50}
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

  def self.filtered_search(search,category,description)
    if search.present? && category.present? && description.present? && category != 'None'  && description != 'None' &&  search != ''
      products = Product.where('name LIKE ?', "%#{search}%").where(category: category).where(description: description)
    elsif  search == '' && category.present? && description == 'None'
      products = Product.where(category: category)
    elsif search == '' && category== 'None' && description.present?
      products = Product.where(description: description)
    elsif search == '' && category.present? && description.present?
      products = Product.where(description: description).where(category: category)
    elsif search.present? && category== 'None' && description== 'None'
      products = Product.where('name LIKE ?', "%#{search}%")
    elsif search.present? && category== 'None' && description.present?
      products = Product.where('name LIKE ?', "%#{search}%").where(description: description)
    elsif search.present? && category.present? && description== 'None'
      products = Product.where('name LIKE ?', "%#{search}%").where(category: category)
    end
    products
  end
end
