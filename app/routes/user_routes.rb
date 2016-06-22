get '/users/logout' do
  user_signout
end

get '/users/new' do
  erb :'users/new'
end
# User is signing in.
post '/users/new' do
  create_user_signup
end

get '/login' do
  erb :'sessions/new'
end

get '/users/next-deeds' do
  list = User.find_by(id: params[:id]).deeds.limit(MAX_SHOW).offset(session[:pagination_spot]).order(id: :DESC)
  if list.size > 0
    erb :'../views/deeds/_pagination', layout:false, locals: {list: list, all_details: false}
  else
    "end-pagination"
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

post '/login' do 
  # User is signing in.
  @user = User.authenticate(params)
  if @user
    user_signin(@user)
    redirect '/'
  else
    erb :'sessions/new'
  end
end

get '/users/:id' do |id|
  if @user = User.find_by(id: id)
    erb :'users/profile'
  else
    redirect '/404'
  end
end

