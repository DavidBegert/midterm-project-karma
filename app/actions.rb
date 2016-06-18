# Homepage (Root path)
set sessions: true

helpers MyHelpers

MAX_SHOW = 5

# before '/' do 
#   session[:pagination_spot] = 0
# end    

get '/' do
  session[:pagination_spot] = 0
  erb :index
end

get '/donate' do
  erb :donate
end

post '/donate' do
  puts params.to_s
end

require_relative './routes/deed_routes'
require_relative './routes/user_routes'

# User is signing in.
# post '/users/signin' do
#   if user = User.authenticate(params)
#     sign_user_in(user)
#   else
#     sign_user_out
#   end
#   redirect '/'
# end
