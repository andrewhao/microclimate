require 'json'
# Represents a source code repository object on CodeClimate.
module Microclimate
  class Repository < Base
    attr_accessor :repo_id, :client

    extend Forwardable

    # @param [Hash] options An option hash of:
    #   +repo_id+: The SHA identifier of the repository on Code Climate.
    def initialize(client, options)
      @client = client
      @repo_id = options[:repo_id]
    end

    delegate :api_token => :client

    def status
      output = connection.get resource_url, :api_token => api_token
      json = output.body
      Response.new JSON.parse(json)
    end

    def refresh!
      output = connection.post resource_refresh_url, :api_token => api_token
      json = output.body
      Response.new JSON.parse(json)
    end

    def resource_refresh_url
      "#{resource_url}/refresh"
    end

    def resource_url
      "/api/repos/#{repo_id}"
    end
  end
end

