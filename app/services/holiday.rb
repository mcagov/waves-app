class Holiday
  require "net/http"

  Event = Struct.new(:holiday_date, :title)

  class << self
    def all
      uri = URI("https://www.gov.uk/bank-holidays.json")
      response = JSON.parse(Net::HTTP.get(uri))

      response["england-and-wales"]["events"].map do |event|
        Event.new(Date.parse(event["date"]), event["title"])
      end.reverse
    rescue
      []
    end
  end
end
