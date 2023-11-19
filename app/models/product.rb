# frozen_string_literal: true

class Product < ActiveRecord::Base

  mount_uploader :image, ImageUploader

  validates :name, presence: true, length: {maximum: 50}
  # validates :image, presence: true
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

  def transaction()
    price = self.price.to_i
    if price < 10
      commission_price = price - (0.1 * price)
    else
      commission_price = price - (0.15 * price)
    end
    self.price = commission_price.to_s
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

  def self.filtered_search(options = {})
    products_list =[]
    if options[:search].present?
      products_list = Product.where('name LIKE ?', "%#{options[:search]}%").where(is_sold?: false)
    elsif options[:categories].present?
      products_list = by_categories(products_list, options[:categories])
    elsif options[:descriptions].present?
      products_list = by_descriptions(products_list, options[:descriptions])
    end
    products_list
  end
  # def self.search(products, param)
  #   products.where('name LIKE ?', "%#{param}%").where(is_sold?: false)
  # end

  def self.by_categories(products, categories)
    if categories.length >= 2
      categories.each do |separate_categories|
        products.where(category: separate_categories)
      end
    else
      products.where(category: categories)
    end
  end

  def self.by_descriptions(products, descriptions)
    if descriptions.length >= 2
      descriptions.each do |separate_descriptions|
        products.where(description: separate_descriptions)
      end
    else
      products.where(description: descriptions)
    end
  end
  # Searches database for specified product name, can return multiple products
  #def self.search_by_name(search)
    # if search.present?
    #   @products = products.where('name LIKE ?', "%#{params[:search]}%").where(is_sold?: false)
    # else
    #   self
    # end
  #end

  # Searches database for specifies product category, can return multiple products
  #def self.search_by_category(search)
    # if search.present?
    #   search.split(', ').each do |categories|
    #     @product = products.where("category=#{categories}")
    #   end
    # else
    #   self
    # end
    # if search.present?
    #   @product = products.where("category=#{search}")
    # else
    #   self
    # end
  #end

  #def self.search_by_description(search)
    # if search.present?
    #   search.split(', ').each do |descriptions|
    #     @product = products.where("description=#{descriptions}")
    #   end
    # else
    #   self
    # end
  #end

end
