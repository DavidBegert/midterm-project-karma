module MyHelpers

  # Current user, returns nil if there is none. (can be used to see if user is logged in)
  def current_user
    User.find_by(id: session[:user_id])
  end

  # Clears the session, signs the user out.
  def user_signout
    session.clear
  end

  # Signs an already-authenticated user in.
  def user_signin(user)
    session[:user_id] = user.id
  end

  # Gives the total karma for the specified user.
  def user_karma_tally(user)
    user.deeds.inject(0) { |sum, deed| sum + deed.votes.sum(:value) }
  end

end