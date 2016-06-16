get '/users/:id' do
  erb :user
end


# User is signing in.
post '/users/signin' do
  # User always signs in, no auth for demo/test purposes
  
  #if user = User.authenticate(params)
    user_signin(User.find_by(username: params[:username]))
  #else
    #user_signout
  #end
  redirect '/'
end