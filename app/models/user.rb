class User < ActiveRecord::Base
  include BCrypt
  has_many :deeds
  has_many :votes
  has_many :comments
  has_many :payments

  validates :email, uniqueness: true, presence: true, format: { with: /\A.+@.+\Z/, message: "invalid email"}
  validates :username, uniqueness: true, presence: true
  validates :image_url, presence: true, format: { with: /\A.+\.(jpg|JPG|png|PNG|jpeg|JPEG)\Z/, message: "invalid url" }
  validates :password_hash, presence: true

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def self.authenticate(params)
    user = User.find_by("username == ?",params[:username])
    if user && user.password == params[:password]
      user
    else
      false
    end
  end

  def total_deeds
    deeds.count
  end

  def total_donations
    payments.sum(:payment_amount)
  end
end
