require "spec_helper"

describe Microclimate::Repository do
  let(:repo_id) { "my_repo_id" }
  let(:api_token) { "my_api_token" }
  let(:client) { mock("client", :api_token => api_token) }
  subject { described_class.new client, :repo_id => repo_id }

  describe "#new" do
    it "returns an instance of Repository" do
      expect(subject).to be_instance_of described_class
    end
  end

  describe "#refresh!" do
    let(:url) { subject.host + "/api/repos/" + repo_id + "/refresh" }
    let(:json_response) do
      <<-JSON
      {"hello": "world"}
      JSON
    end

    before :each do
      stub_request(:post, url).with(:api_token => api_token).to_return(:body => json_response)
    end

    it "POSTs to /api/repos/:repo_id/refresh" do
      subject.refresh!

      expect(a_request(:post, url)).to have_been_made
    end
  end

  describe "#status" do
    let(:url) { subject.host + "/api/repos/" + repo_id + "?api_token=" + api_token }
    let(:json_response) do
      <<-JSON
      {"hello": "world"}
      JSON
    end

    before :each do
      stub_request(:get, url).with(:api_token => api_token).to_return(:body => json_response)
    end

    it "queries codeclimate API URL correctly." do
      subject.status

      expect(a_request(:get, url)).to have_been_made
    end

    it "returns a Response object" do
      expect(subject.status).to be_instance_of Microclimate::Response
    end
  end
end
