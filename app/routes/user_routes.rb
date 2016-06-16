get '/users/:id' do
  erb :user
end


# User is signing in.
# post '/users/signin' do
#   if user = User.authenticate(params)
#     sign_user_in(user)
#   else
#     sign_user_out
#   end
#   redirect '/'
# end
