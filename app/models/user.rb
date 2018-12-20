class User < ApplicationRecord
  attr_reader :password 
  after_initialize :ensure_session_token

  # password=
  def password=(password)
    @password = password 
    # why do we not need self.save here?
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    bcrypt_password = BCrypt::Password.new(self.password_digest)
    bcrypt_password.is_password?(password)
  end

  # User find_by 
  def self.find_by_credentials(email, password) 
    user = User.find_by(email: email)
    return nil unless user && user.is_password?(password)
    user 
  end

  def reset_session_token! 
    self.update!(session_token: self.class.generate_session_token)
    self.session_token 
  end
  
  private 
  def ensure_session_token 
    self.session_token ||= self.class.generate_session_token 
  end

  def self.generate_session_token
    # code 64 to generate a session token 
    SecureRandom::urlsafe_base64(16)
  end
end