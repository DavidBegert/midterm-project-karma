# Homepage (Root path)
set sessions: true

helpers do 
  def current_user
    User.find_by(id: session[:user_id])
  end

end

before do 
  #stuff
end

get '/' do
  erb :index
end

get '/users/:id' do
  erb :user
end

post '/' do 


end



