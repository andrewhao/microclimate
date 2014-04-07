require "spec_helper"
require "ostruct"

describe Microclimate::Snapshot do
  let(:gpa) { 3.00 }
  let(:sha) { "abcdef1234" }
  let(:data) do
    json = {
      :gpa => gpa,
      :commit_sha => sha
    }
    OpenStruct.new(json)
  end
  let(:subject) { described_class.new(data) }

  describe "#gpa" do
    it "returns the json GPA" do
      expect(subject.gpa).to eq gpa
    end
  end

  describe "#commit_sha" do
    it "returns json sha" do
      expect(subject.commit_sha).to eq sha
    end
  end
end
