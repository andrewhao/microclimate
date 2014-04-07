module Microclimate
  class Branch < Repository
    attr_accessor :parent_repo, :name

    def initialize(client, parent_repo, name)
      @client = client
      @parent_repo = parent_repo
      @name = name
    end

    delegate :repo_id => :parent_repo

    protected

    def resource_url
      "/api/repos/#{repo_id}/branches/#{name}"
    end
  end
end
