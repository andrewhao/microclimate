module Microclimate
  class Client
    attr_accessor :api_token

    def initialize(options)
      @api_token = options[:api_token]
    end

    def repository_for(repo_id)
      Microclimate::Repository.new(self, :repo_id => repo_id)
    end
  end
end
