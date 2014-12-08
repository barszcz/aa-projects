class User < ActiveRecord::Base
  validates :email, :password_digest, :session_token, presence: true
  validates :password, length: { minimum: 6, allow_nil: true}

  after_initialize :ensure_session_token, :ensure_activation_token, :ensure_activation_status

  attr_accessor :password

  has_many :notes

  def activated?
    self.activated
  end

  def admin?
    self.admin
  end

  def ensure_session_token
    self.session_token ||= generate_token
  end

  def ensure_activation_token
    self.activation_token ||= generate_token
  end

  def ensure_activation_status
    self.activated ||= false
  end

  def reset_session_token!
    self.session_token = generate_token
    self.save!
    self.session_token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def activate!
    self.update(activated: true)
  end

  def self.find_by_credentials(email, password)
    user = User.find_by(email: email)
    return nil if user.nil? || !(user.is_password?(password))
    user
  end

  private

    def generate_token
      SecureRandom.urlsafe_base64
    end
end
