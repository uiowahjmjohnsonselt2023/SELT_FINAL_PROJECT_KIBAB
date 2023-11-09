class User < ActiveRecord::Base
  before_save {|user| user.email=user.email.downcase}

  has_secure_password
  #before_save :create_session_token
  validates :first_name, presence: true, length: {maximum: 50}
  validates :last_name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.\z/i
  validates :email, presence: true,
            format: {with: VALID_EMAIL_REGEX},
            uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum:6}
  validates :password_confirmation, presence: true

  #private
  #def create_session_token
  #  self.session_token = SecureRandom.urlsafe_base64
  #end
end
