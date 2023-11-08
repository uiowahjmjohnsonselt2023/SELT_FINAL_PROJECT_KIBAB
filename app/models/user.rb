class User < ActiveRecord::Base
  before_save {|user| user.email=user.email.downcase}
  #before_save :create_session_token
  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.\z/i
  validates :email, presence: true,
            format: {with: VALID_EMAIL_REGEX},
            uniqueness: {case_sensitive: false}

  #private
  #def create_session_token
  #  self.session_token = SecureRandom.urlsafe_base64
  #end
end
