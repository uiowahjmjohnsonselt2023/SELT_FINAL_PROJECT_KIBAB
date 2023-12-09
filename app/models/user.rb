class User < ActiveRecord::Base

  has_many :product
  has_one :wallet

  # User implementation should be credited to the slides titled Slides11.ppx presented in class
  # and "Single Sign-On and Third Party Authentication"
  # presented in class during week of 11/6

  ## Additional documentation
  # Additional tutorial for implementation: https://dev.to/anne46/google-omniauth-in-a-rails-app-36ka
  # Additional implentation strategies: https://github.com/zquestz/omniauth-google-oauth2

  before_save {|user| user.email=user.email.downcase}
  before_save :create_session_token

  private
  def create_session_token
    self.session_token = SecureRandom.urlsafe_base64
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.uid = auth['uid']
      user.provider = auth['provider']
      user.email = auth['info']['email']
      user.name = auth['info']['name']
      user.pfp = auth['info']['image']
      # default is set to 100 right now for testing purposes
      user.build_wallet(wallet: 100.0)
    end
  end
end