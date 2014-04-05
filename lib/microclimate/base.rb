require "faraday"

module Microclimate
  class Base
    def connection
      @connection ||= ::Faraday.new(:url => host) do |faraday|
        faraday.request  :url_encoded             # form-encode POST params
        faraday.response :logger                  # log requests to STDOUT
        faraday.adapter  ::Faraday.default_adapter  # make requests with Net::HTTP
      end
    end

    def host
      "https://codeclimate.com"
    end
  end
end
