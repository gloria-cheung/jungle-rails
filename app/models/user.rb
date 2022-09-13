class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: {case_sensitive: false}
  validates :password, length: { minimum: 8 }
  validates :first_name, presence: true
  validates :last_name, presence: true

  private

  def self.authenticate_with_credentials(email, password)
    # get rid of trailing and leading spaces & is case insensitive
    email = email.strip.downcase
    user = User.find_by_email(email)
    # If the user exists AND the password entered is correct.
    if user && user.authenticate(password)
      user
    else
      nil
    end
  end
end
