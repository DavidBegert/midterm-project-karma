class User < ActiveRecord::Base
  include BCrypt
  has_many :deeds

  validates :email, uniqueness: true, presence: true, format: { with: /\A\w+@\+\Z/, message: "invalid email"}
  validates :username, uniqueness: true, presence: true
  validates :image_url, presence: true, format: { with: /\Ahttp:\/\/.+\.(jpg|JPG|png|PNG)\Z/, message: "invalid url" }
  validates :password_hash, presence: true

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def self.authenticate(params)
    user = User.find_by("email == ?",params[:input_email])
    if user && user.password == params[:input_password]
      user
    else
      false
    end
  end
end