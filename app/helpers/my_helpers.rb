module MyHelpers

  # Current user, returns nil if there is none. (can be used to see if user is logged in)
  def current_user
    User.find_by(id: session[:user_id])
  end

  # Clears the session, signs the user out.
  def user_signout
    session.clear
    redirect '/'
  end

  # Signs an already-authenticated user in.
  def user_signin(user)
    session[:user_id] = user.id
  end

  def user_signup
    if current_user
      redirect '/'
    end
    @user = User.new
    erb :'/users/new'  
    # not sure what this function is doing
  end

  # Creates a user
  def create_user_signup
    @user = User.new(
      username: params[:username],
      email: params[:email],
      image_url: params[:image_url],
      password: params[:password]
    )
    if @user.save
      user_signin(@user)
      redirect '/'
    else
      erb :'/users/new'
    end
  end


  # Gives the total karma for the specified user.
  def user_karma_tally(user)
    user.deeds.joins(:votes).sum("votes.value")
  end

  # Get a list of all users to login with the dropdown
  def get_login_dropdown_user_list
    html = "<form method=\"post\" action=\"/users/signin\">"
    User.all.each do |user|
      html << "<li>"
      html << "<input type=\"submit\" class=\"width100 btn btn-default\" name=\"username\" value=\"#{user.username}\"/>"
      html << "</li>"
    end
    html << "</form>"
  end

  def datetime_to_modern(datetime)
    zone = ActiveSupport::TimeZone.new("Pacific Time (US & Canada)")
    date_time = datetime.in_time_zone(zone)
    now_time = DateTime.now.in_time_zone(zone)
    puts 1.minute.ago.utc
    if date_time > 1.minute.ago.utc
      "just now"
    elsif date_time >= 2.minutes.ago.utc
      "a minute ago"
    elsif date_time >= 20.minutes.ago.utc
      "a few minutes ago"
    elsif date_time >= 45.minutes.ago.utc
      "half hour ago"
    elsif date_time >= 1.hour.ago.utc
      "an hour ago"
    elsif date_time.to_date == now_time.to_date
      "today"
    elsif date_time.to_date == (now_time - 1.day).to_date
      "yesterday"
    else
      "a few days ago"
    end      
  end

  # Gives the total praises for the specified user.
  def user_praise_tally(user)
    user.deeds.joins(:votes).where("votes.value = 1").count
  end

  # Gives the total shames for the specified user.
  def user_shame_tally(user)
    user.deeds.joins(:votes).where("votes.value = -1").count
  end

  # Gives the total number of praises for a specific deed
  def deed_praise_tally(deed)
    deed.votes.where(value: 1).count
  end

  # Gives the total number of shames for a specific deed
  def deed_shame_tally(deed)
    deed.votes.where(value: -1).count
  end
 
  # Add a praise vote for the deed assigning the authorship to the current user
  def create_praise
    @praise = Vote.create!(
      deed_id: params[:id],
      user_id: session[:user_id],
      value: 1
    )
    deed_praise_tally(Deed.find(params[:id]))
  end

 
  # Add a shame vote for the deed assigning the authorship to the current user
  def create_shame
    @shame = Vote.create!(
      deed_id: params[:id],
      user_id: session[:user_id],
      value: -1
    )
    deed_shame_tally(Deed.find(params[:id]))
  end

  def get_worst_deed(user)
    if user_shame_tally(user) > 0
      Deed.find_by_sql("SELECT deeds.* FROM deeds JOIN votes ON votes.deed_id = deeds.id WHERE deeds.user_id = #{user.id} GROUP BY deeds.id ORDER BY SUM(votes.value) ASC LIMIT 1;")[0]
    end
  end
end
