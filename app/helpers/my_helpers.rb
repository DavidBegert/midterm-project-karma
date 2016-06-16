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
    user.deeds.joins(:votes).sum("votes.value")
  end

  # Get a list of all users to login with the dropdown
  def get_login_dropdown_user_list
    html = "<form method=\"post\" action=\"users/signin\">"
    User.all.each do |user|
      html << "<li>"
      html << "<input type=\"submit\" class=\"width100 btn btn-default\" name=\"username\" value=\"#{user.username}\"/>"
      html << "</li>"
    end
    html << "</form>"
  end

  def datetime_to_modern(datetime)
    if datetime > 1.minute.ago
      "just now"
    elsif datetime >= 2.minutes.ago
      "a minute ago"
    elsif datetime >= 20.minutes.ago
      "a few minutes ago"
    elsif datetime >= 45.minutes.ago
      "half hour ago"
    elsif datetime >= 1.hour.ago
      "an hour ago"
    elsif datetime.date == DateTime.now.date
      "today"
    elsif dateTime.date == (DateTime.now - 1.day).to_date
      "yesterday"
    else
      "a few days ago"
    end      
  end
end