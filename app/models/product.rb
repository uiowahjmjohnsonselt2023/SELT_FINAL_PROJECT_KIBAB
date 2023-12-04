
class Product < ActiveRecord::Base

  mount_uploader :image, ImageUploader

  belongs_to :user

  validates :name, presence: true, length: {maximum: 50}
  validates :category, presence: true, length: {maximum: 50}
  validates :quality, presence: true
  validates :description, presence: true, length: {maximum: 100}
  #TODO: Fix regex expression controlling price, add validation location, quality, and categories
  VALID_PRICE_REGEX = /\d+()|(.\d\d)/
  validates :price, presence: true, format: {with: VALID_PRICE_REGEX} # Regex for US dollar format
  #validates :location, presence: true # Formatting may be needed in the future

  def transaction
    price = self.price.to_i
    if price < 10
      commission_price = price - (0.1 * price)
    else
      commission_price = price - (0.15 * price)
    end
    commission_to_return = "%.2f" % [commission_price]
  end
  def valid_price?
    price_regex = /\A\d+\.\d{2}\z/
    self.price.match?(price_regex)
  end

  def valid_quality?
    ['Well Worn', 'Used', 'Like New', 'New'].include?(self.quality)
  end

  def valid_category?
    ['Home', 'Entertainment', 'Clothing', 'Personal Care', 'Office', 'Other'].include?(self.category)
  end

  def self.valid_address(city,state,address,zip)
    run_it = false
    if run_it
      client = SmartyStreetsConfig.client
      lookup = SmartyStreets::USStreet::Lookup.new
      lookup.street = address
      lookup.state = state
      lookup.city = city
      lookup.zipcode = zip
      lookup.candidates = 3
      lookup.match = SmartyStreets::USStreet::MatchType::STRICT
      begin
        client.send_lookup(lookup)
      rescue SmartyStreets::SmartyError => err
        result = "Got the error" + err.to_s
        return result
      end
      if lookup.result.empty?
        false
      else
        true
      end
    else
      true
    end
  end

  def self.filtered_search(search,category,quality)
    # if search.present? && category.present? && quality.present? && category != 'None'  && quality != 'None' &&  search != ''
    #   products = Product.where('name LIKE ?', "%#{search}%").where(category: category).where(quality: quality)
    # elsif  search == '' && category.present? && quality == 'None'
    #   products = Product.where(category: category)
    # elsif search == '' && category== 'None' && quality.present?
    #   products = Product.where(quality: quality)
    # elsif search == '' && category.present? && quality.present?
    #   products = Product.where(quality: quality).where(category: category)
    # elsif search.present? && category== 'None' && quality== 'None'
    #   products = Product.where('name LIKE ?', "%#{search}%")
    # elsif search.present? && category== 'None' && quality.present?
    #   products = Product.where('name LIKE ?', "%#{search}%").where(quality: quality)
    # elsif search.present? && category.present? && quality== 'None'
    #   products = Product.where('name LIKE ?', "%#{search}%").where(category: category)
    # end
    # products
    # products = Product.all
    # products = products.where('name LIKE ?', "%#{search}%") if search.present?
    # products = products.where(quality: quality) if quality.present? && quality != 'None'
    # products = products.where(category: category) if category.present? && category != 'None'
    #
    # products
    products = Product.all

      products = products.where('name LIKE ?', "%#{search}%") if search.present?

      if quality.present? && quality != 'None'
        products = products.where(quality: quality)
      end

      if category.present? && category != 'None'
        products = products.where(category: category)
      end

      products
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

  def self.add_to_bookmarks(user_id, product_id)
    var = Bookmark.where(user_id: user_id).where(product_id: product_id).present?
    if !var.present?
      bookmark = {:user_id => user_id, :product_id => product_id}
      Bookmark.create!(bookmark)
    end
  end

  def set_sold_true
    self.is_sold = true
    self.save
  end
end
