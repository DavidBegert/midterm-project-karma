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
  if session[:pagination_spot] == Deed.last.id
    puts "ITS DONE"
  else 
    erb :'../views/deeds_pagination'
  end
end