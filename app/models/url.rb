class Url < ActiveRecord::Base
	# This is Sinatra! Remember to create a migration!
  validates :long_url, presence: true
  before_save :shorten
  validates :long_url, uniqueness: true, format: {with: /(\w+\.)+\w{2,}/, message: "is not a valid url"}

  def shorten
    if self.short_url.nil?
      self.short_url = SecureRandom.hex(4)
    end
  end

end
