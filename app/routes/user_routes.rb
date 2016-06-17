get '/users/logout' do
  user_signout
end

get '/users/signup' do
  user_signup
end

post '/users/signup' do
  create_user_signup
end

get '/users/next-deeds' do
  puts "PARAMS ARE --> " << params.to_s
  list = User.find_by(id: params[:id]).deeds.limit(MAX_SHOW).order(id: :DESC)
  unless session[:pagination_spot] == list.last.id
    erb :'../views/deeds/_pagination', layout:false, locals: {list: list, all_details: false}
  end
end

get '/users/:id' do |id|
  session[:pagination_spot] = 0
  if @user = User.find_by(id: id)
    erb :'users/profile'
  else
    redirect '/404'
  end
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
