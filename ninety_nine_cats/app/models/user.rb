class User < ActiveRecord::Base
  validates :username, :password_digest, :session_token, presence: true
  validates :username, :session_token, uniqueness: true

  has_many(
    :cats,
    class_name: "Cat",
    foreign_key: :user_id,
    primary_key: :id
  )

  has_many(
    :cat_rental_requests,
    class_name: "CatRentalRequest",
    foreign_key: :user_id,
    primary_key: :id
  )

  after_initialize do
    self.session_token ||= SecureRandom.urlsafe_base64
  end

  def reset_session_token!
    self.update!(session_token: SecureRandom.urlsafe_base64)
  end

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    pd = BCrypt::Password.new(password_digest)
    pd.is_password?(password)
  end

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    return nil if user.nil?
    user.is_password?(password) ? user : nil
  end
end
