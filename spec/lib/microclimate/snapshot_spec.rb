require "spec_helper"
require "ostruct"

describe Microclimate::Snapshot do
  let(:gpa) { 3.00 }
  let(:sha) { "abcdef1234" }
  let(:utc_seconds) { 1368165666 }
  let(:data) do
    json = {
      :gpa => gpa,
      :commit_sha => sha,
      :finished_at => utc_seconds
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

  describe "#finished_at" do
    it "returns a DateTime" do
      expect(subject.finished_at).to be_instance_of DateTime
    end
  end
end
