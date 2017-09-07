connection = ActiveRecord::Base.connection
time = Time.now()
pumpkin = ""
@final_value = ""
File.read('url').each_line do |i|
    mvar = i
    mvar.chomp!
    mvar.gsub!(/[(),]/, "")
    pumpkin = SecureRandom.hex(3)
    @final_value << "('#{mvar}', '#{pumpkin}', 0, '#{Time.now.getutc}', '#{Time.now.getutc}'), "
    #byebug
end
@final_value = @final_value[0..-3]
#byebug
connection.execute "INSERT INTO urls (long_url, short_url, click_count, created_at, updated_at) VALUES #{@final_value}"
p Time.now - time
