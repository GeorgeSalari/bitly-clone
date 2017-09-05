class Url < ActiveRecord::Base
	# This is Sinatra! Remember to create a migration!
  validates :long_url, presence: true
  before_save :shorten
  before_validation :check_long_url
  validates :long_url, uniqueness: true, format: {with: /(\w+\.)+\w{2,}/, message: "Is not a valid url"}

  def shorten
    if self.short_url.nil?
      self.short_url = "http://localhost:9393/#{SecureRandom.hex(4)}"
    end
  end

  def check_long_url
    if !self.long_url.include? "https://"
      if !self.long_url.include? "www."
        if self.long_url =~ /(\w+\.)+\w{2,}/
          self.long_url = "https://www.#{self.long_url}"
        end
      else
        string = self.long_url.partition("www.")
        if string[2] =~ /(\w+\.)+\w{2,}/
          self.long_url = "https://#{self.long_url}"
        else
          self.long_url = string[2]
        end
      end
    else
      string = self.long_url.partition("https://")
      if string[2].include? "www."
        string1 = string[2].partition("www.")
        if (string1[2] =~ /(\w+\.)+\w{2,}/) == nil
          self.long_url = string1[2]
        end
      end
    end
  end

end


# if params[:long_url].include? "https://www."
#     url.long_url = params[:long_url]
#   elsif params[:long_url].include? "https://"
#     string = params[:long_url].partition("https://")
#     if string[2] =~ /(\w+\.)+\w{2,}/
#       url.long_url = "#{string[1]}www.#{string[2]}"
#     else
#       url.long_url = string[2]
#     end
#   elsif params[:long_url].include? "www."
#     string = params[:long_url].partition("www.")
#     if string[2] =~ /(\w+\.)+\w{2,}/
#       url.long_url = "https://#{string[1]}#{string[2]}"
#     else
#       url.long_url = string[2]
#     end
#   else params[:long_url] != ""
#     url.long_url = params[:long_url]
#   end
