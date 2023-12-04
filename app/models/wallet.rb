class Wallet < ActiveRecord::Base
  def self.check_credit(name,number,cvv,date)
    problem = ''
    problem_flag = false
    name_regex = /^[A-Za-z\s'-]+$/
    number_regex = /\b(?:\d[ -]*?){13,16}\b/
    cvv_regex = /\A\d{3,4}\z/
    date_regex = /\A(0[1-9]|1[0-2])\/(0[1-9]|[12][0-9]|3[01])\/\d{4}\z/
    if !name.match?(name_regex) && !problem_flag
      problem = 'There was a problem with you name, please only use letters'
      problem_flag = true
    elsif !number.match?(number_regex) && !problem_flag
      problem = 'There was a problem with you credit card number make sure it is the right length and only includes numbers'
      problem_flag = true
    elsif !cvv.match?(cvv_regex) && !problem_flag
      problem = 'There was a problems with the cvv make sure it is the right length and only includes numbers'
      problem_flag = true
    elsif date.present?
      if !date.match?(date_regex) && !problem_flag
        problem = 'Make sure the sure the data follow mm/dd/yyyy format'
        problem_flag = true
      elsif Date.parse(date) <= Date.today  && !problem_flag
        problem = 'Your card cannot be expired'
      end
    end
    problem
  end
  belongs_to :user
end
