class User < ActiveRecord::Base
  before_save { self.login = login.downcase }
  before_create :create_remember_token

  has_many :posts, dependent: :delete_all
  has_many :topics, dependent: :delete_all

  validates :login, length: { maximum:50, minimum: 5 },
                          uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }
  has_secure_password

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

  def create_remember_token
    self.remember_token = User.digest(User.new_remember_token)
  end

end
