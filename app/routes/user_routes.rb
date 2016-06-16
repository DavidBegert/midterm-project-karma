get '/users/logout' do
  user_signout
end

get '/users/:id' do
  erb :'users/show'
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
