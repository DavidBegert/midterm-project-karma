# Homepage (Root path)
set sessions: true

helpers MyHelpers

get '/' do
  erb :index
end

require_relative './routes/deed_routes'
require_relative './routes/user_routes'