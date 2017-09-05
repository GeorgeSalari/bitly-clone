get '/' do
  erb :"static/index"
end

get '/sign_up' do
  erb :"static/sign_up"
end

get '/:short_url' do
  # redirect to long url
  url = Url.find_by(short_url: "http://localhost:9393/#{params[:short_url]}")
  url.update(click_count: "#{url.click_count + 1}")
  redirect "#{url.long_url}"
end

post '/urls' do
  url = Url.new(long_url: params[:long_url])
  if url.save
    @short_url = url.short_url
    # erb :"static/index"
    url.to_json
  elsif Url.find_by(long_url: url.long_url)
    my_url = Url.find_by(long_url: url.long_url)
    count = 1
    line = 0
    all_url = Url.order("click_count desc")
    all_url.each do |url|
      line = count if url == my_url
      count += 1
    end
    @message = "You have this url! Look at your table line #{line}"
    # erb :"static/index"
    { message: @message }.to_json
  else
    if url.errors.messages[:long_url][0] == "Is not a valid url"
      @message = "#{url.errors.messages[:long_url][0]}"
    else
      @message = "url #{url.errors.messages[:long_url][0]}"
    end
    # erb :"static/index"
    { message: @message }.to_json
  end

end
