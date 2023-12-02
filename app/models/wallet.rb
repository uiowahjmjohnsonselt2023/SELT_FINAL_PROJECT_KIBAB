class Wallet < ActiveRecord::Base
  def self.check_date(date)

  end
  def self.check_cvv(cvv)

  end
  def self.check_number(number)

  end
  def self.check_name(name)

  end

  belongs_to :user
end
