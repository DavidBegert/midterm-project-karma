get '/users/logout' do
  user_signout
end

get '/users/new' do
  erb :'users/new'
end
# User is signing in.
post '/users/new' do
  create_user_signup(params)

end

get '/login' do
  erb :'sessions/new'
end

post '/login' do 
  # User is signing in.
  #if user = User.authenticate(params)
  @user = user_signin(User.find_by(username: params[:username]))

  #else
    #user_signout
  #end
  redirect '/' 
end

get '/users/:id' do |id|
  if @user = User.find_by(id: id)
    erb :'users/profile'
  else
    redirect '/404'
  end
end

