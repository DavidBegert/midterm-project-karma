# Homepage (Root path)
set sessions: true

helpers MyHelpers

MAX_SHOW = 50

get '/' do
  erb :index
end

require_relative './routes/deed_routes'
require_relative './routes/user_routes'
get '/users/:id' do
  erb :'users/show'
end

# post '/' do 
#   @deed = Deed.new(
#     user_id: current_user.id
#     summary: params[:summary]
#     )
#   if @deed.save
#
#   else
#
#   end
# end

# User is signing in.
# post '/users/signin' do
#   if user = User.authenticate(params)
#     sign_user_in(user)
#   else
#     sign_user_out
#   end
#   redirect '/'
# end
