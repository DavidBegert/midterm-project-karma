# User is praising/shaming a deed.
post '/deeds/:id/vote' do

end


post '/deeds' do 
  @deed = Deed.new(
    user_id: current_user.id,
    summary: params[:summary]
    )
  if @deed.save
    redirect '/'
  else
    redirect '/'
  end
end

get '/deeds/next' do 
  unless session[:pagination_spot] == Deed.last.id
    erb :'../views/deeds/_pagination', locals: {list: Deed.all.limit(MAX_SHOW).offset(session[:pagination_spot]).order(id: :desc)}
  end
end 