get '/users/logout' do
  user_signout
end

get '/users/signup' do
  user_signup
end

post '/users/signup' do
  create_user_signup(params)
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

get '/users/:id' do
  erb :user
end
