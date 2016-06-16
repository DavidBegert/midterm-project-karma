# User is praising/shaming a deed.
post '/deeds/:id/vote' do

end


post '/deeds' do 
  deed = Deed.new(
    user_id: current_user.id,
    summary: params[:summary]
    )
  if deed.save
    erb :'../views/deeds/_show', layout: false, locals: {deed: deed}
  else
    redirect '/'
  end
end

get '/deeds/next' do 
  unless session[:pagination_spot] == Deed.last.id
    erb :'../views/deeds/_pagination', layout: false, locals: {list: Deed.all.limit(MAX_SHOW).offset(session[:pagination_spot]).order(id: :desc)}
  end
end 