require 'spec_helper'

describe Microclimate::Client do
  let(:api_token) { "my_api_token" }
  subject { described_class.new(:api_token => api_token) }

  describe "#new" do
    it "initializes correctly with params" do
      expect(subject).to be_instance_of described_class
    end
  end

  describe "#api_token" do
    it "returns the attr" do
      expect(subject.api_token).to eq api_token
    end
  end

  describe "#repository_for" do
    let(:repo_id) { "my repo id" }

    it "returns an instance of Microclimate::Repository" do
      expect(subject.repository_for(repo_id)).to be_instance_of Microclimate::Repository
    end
  end
end
