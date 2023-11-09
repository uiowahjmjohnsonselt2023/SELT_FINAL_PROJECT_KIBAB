# frozen_string_literal: true

class Product < ActiveRecord::Base
  validates :name, presence: true, length: {maximum: 50}
  validates :category, presence: true, length: {maximum: 50}
  validates :description, presence: true, :allow_blank => true # Default product blank, can change later
  VALID_PRICE_REGEX = /\$\d+()|(.\d\d)/
  validates :price, presence: true, format: {with: VALID_PRICE_REGEX} # Regex for US dollar format
  validates :location, presence: true # Formatting may be needed in the future
  validates :is_sold?, presence: true
  validates :user_id, presence: true, :allow_nil => true # Populates when is_sold? is true
  validates :seller_id, presence: true
end
