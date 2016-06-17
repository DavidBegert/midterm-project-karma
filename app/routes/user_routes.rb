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

get '/users/next-deeds' do
  puts "PARAMS ARE --> " << params.to_s
  list = User.find_by(id: params[:id]).deeds.limit(MAX_SHOW).offset(session[:pagination_spot]).order(id: :DESC)
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

post '/users/signin' do 
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

