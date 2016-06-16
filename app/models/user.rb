class User < ActiveRecord::Base
  include BCrypt
  has_many :deeds
  has_many :votes

  validates :email, uniqueness: true, presence: true, format: { with: /\A.+@.+\Z/, message: "invalid email"}
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

  # def get_worst_deed 
  #   Deed.find_by_sql("SELECT * FROM deeds JOIN votes ON votes.deed_id = deeds.id WHERE deeds.user_id = ? ORDER BY SUM()
  # end

end
