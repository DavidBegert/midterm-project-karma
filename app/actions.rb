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
  payment = Payment.create!(user: current_user, payment_amount: params[:donation])
end

require_relative './routes/deed_routes'
require_relative './routes/user_routes'