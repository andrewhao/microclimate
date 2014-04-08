module Microclimate
  class Branch < Repository
    attr_accessor :parent_repo, :name

    def initialize(client, parent_repo, name)
      @client = client
      @parent_repo = parent_repo
      @name = name
    end

    delegate :repo_id => :parent_repo

    def www_url
      "https://codeclimate.com/repos/#{repo_id}/compare/#{name}"
    end

    protected

    def resource_url
      "/api/repos/#{repo_id}/branches/#{name}"
    end
  end
end
