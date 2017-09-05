get '/' do
  erb :"static/index"
end

get '/sign_up' do
  erb :"static/sign_up"
end

get '/:short_url' do
  # redirect to long url
  url = Url.find_by(short_url: "#{params[:short_url]}")
  url.update_click_count
  redirect "#{url.long_url}"
end

post '/urls' do
  url = Url.new(long_url: params[:long_url])
  if url.save
    url.to_json
  else
    url.errors.to_json
  end
end

post '/create_user' do
  @params = params
end
