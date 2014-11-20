# A Code Climate report.
module Microclimate
  class Snapshot < Base
    attr_accessor :data
    extend Forwardable

    def initialize(data)
      @data = data
    end

    def finished_at
      DateTime.new(data.finished_at)
    end

    delegate :gpa => :data,
      :commit_sha => :data
  end
end
