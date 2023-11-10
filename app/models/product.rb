# frozen_string_literal: true

class Product < ActiveRecord::Base
  has_and_belongs_to_many :users

  validates :name, presence: true, length: {maximum: 50}
  validates :category, presence: true, length: {maximum: 50}
  validates :description, presence: true, :allow_blank => true # Default product blank, can change later
  VALID_PRICE_REGEX = /\d+()|(.\d\d)/
  validates :price, presence: true, format: {with: VALID_PRICE_REGEX} # Regex for US dollar format
  validates :location, presence: true # Formatting may be needed in the future
  validates :user_email, presence: true

  def set_user_email(email)
    self.user_email = email
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

end
