# User is praising/shaming a deed.
post '/deeds/:id/praise' do
end

post '/deeds/:id/shame' do
end

post '/deeds' do 
  @deed = Deed.new(
    user_id: current_user.id,
    summary: params[:summary]
    )
  if @deed.save
    redirect '/'
  else
    flash[:info] = "Your confession cannot be blank"
    redirect '/'
  end
end
