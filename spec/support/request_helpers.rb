module Requests
  module JsonHelpers
    def json
      JSON.parse(response.body)["data"]
    end
  end
end
