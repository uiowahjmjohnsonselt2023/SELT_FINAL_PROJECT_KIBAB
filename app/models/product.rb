# frozen_string_literal: true

class Product < ActiveRecord::Base
  has_and_belongs_to_many :users

  validates :name, presence: true, length: {maximum: 50}
  validates :category, presence: true, length: {maximum: 50}
  validates :description, presence: true
  #TODO: Fix regex expression controlling price, add validation location, description, and categories
  VALID_PRICE_REGEX = /\d+()|(.\d\d)/
  validates :price, presence: true, format: {with: VALID_PRICE_REGEX} # Regex for US dollar format
  validates :location, presence: true # Formatting may be needed in the future
  validates :user_email, presence: true

  def set_user_email(email)
    self.user_email = email
  end
end
