get '/' do
  erb :"static/index"
end

get '/:short_url' do
  # redirect to long url
  url = Url.find_by(short_url: params[:short_url])
  url.update(click_count: "#{url.click_count + 1}")
  redirect "https://#{url.long_url}"
end

post '/urls' do
  url = Url.new(long_url: params[:long_url])
  if url.save
    @short_url = url.short_url
    erb :"static/index"
  elsif Url.find_by(long_url: url.long_url)
    url_db = Url.find_by(long_url: url.long_url)
    @short_url = url_db.short_url
    erb :"static/index"
  else
    if url.errors.messages[:long_url][0] == "is not a valid url"
      @message = "#{url.errors.messages[:long_url][0]}"
    else
      @message = "url #{url.errors.messages[:long_url][0]}"
    end
    erb :"static/index"
  end

end
