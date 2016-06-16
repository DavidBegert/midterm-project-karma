# Homepage (Root path)
set sessions: true

helpers do 
  def current_user
    User.find_by(id: session[:user_id])
  end

  def login
    session[:user_id] = 1
  end

  def logout
    session.clear
  end 

end

before do 
  login
end

get '/' do
  erb :index
end

get '/users/:id' do
  erb :'users/show'
end

# post '/' do 
#   @deed = Deed.new(
#     user_id: current_user.id
#     summary: params[:summary]
#     )
#   if @deed.save

#   else

#   end

# end



