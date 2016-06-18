# User is praising/shaming a deed.
post '/deeds/:id/praise' do
  create_praise.to_s
end

post '/deeds/:id/shame' do
  create_shame.to_s
end

post '/deeds' do 
  deed = Deed.new(
    user_id: current_user.id,
    summary: params[:summary]
    )
  if deed.save
    session[:pagination_spot] += 1
    erb :'../views/deeds/_show', layout: false, locals: {all_details: true, deed: deed}
  else
    redirect '/'
  end
end

get '/deeds/next' do 
  list = Deed.all.limit(MAX_SHOW).offset(session[:pagination_spot]).order(id: :desc)
  if list.size > 0
    erb :'../views/deeds/_pagination', layout: false, locals: {all_details: true, list: list}
  else
    "end-pagination"
  end
end

get '/deeds/:id/comments' do |id|
  @comments = Deed.find(id).comments
  erb :'../views/deeds/_comments', layout: false, locals: {deed_id: id}
end

post '/deeds/:id/comments' do |id|
  comment = Comment.new(
    deed_id: id,
    user_id: current_user.id,
    content: params[:content]
    )
  if comment.save
    erb :'../views/deeds/_new_comment', layout: false, locals: {comment: comment}
  else
    redirect '/'
  end
end
