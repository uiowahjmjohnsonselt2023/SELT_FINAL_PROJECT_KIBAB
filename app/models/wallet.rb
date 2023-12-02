class Wallet < ActiveRecord::Base
  def self.check_credit(name,number,cvv,date)
    name_regex = /^[A-Za-z\s'-]+$/
    number_regex = /\b(?:\d[ -]*?){13,16}\b/
    cvv_regex = /\A\d{3,4}\z/
    date_regex = /\A(0[1-9]|1[0-2])\/(0[1-9]|[12][0-9]|3[01])\/\d{4}\z/
    if name.match?(name_regex) && number.match?(number_regex) && cvv.match?(cvv_regex) && date.match?(date_regex)
      true
    else
      false
    end

  end

  belongs_to :user
end
