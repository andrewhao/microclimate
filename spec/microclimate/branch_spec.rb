require "spec_helper"

describe Microclimate::Branch do
  let(:repo_id) { "my_repo_id" }
  let(:repo) { double("repo", :repo_id => repo_id) }
  let(:name) { "my_branch" }
  let(:api_token) { "my_api_token" }
  let(:client) { double("client", :api_token => api_token) }
  let(:subject) { described_class.new(client, repo, name) }
  let(:base_url) { "#{subject.host}/api/repos/#{repo_id}/branches/#{name}" }
  let(:url) { "#{base_url}?api_token=#{api_token}" }
  let(:gpa) { 2.25 }

  let(:last_snapshot) do
    {
      "last_snapshot" => {
        "gpa" => gpa
      }
    }
  end

  let(:json_response) do
    {"id" => repo_id}.merge(last_snapshot)
  end

  describe "#gpa" do
    before :each do
      stub_request(:get, url).with(:api_token => api_token).to_return(:body => json_response.to_json)
    end

    it "hits the branch Code Climate url." do
      expect(subject.gpa).to eq gpa
    end
  end

  describe "#www_url" do
    it "returns the branch compare view" do
      url = "https://codeclimate.com/repos/#{repo_id}/compare/#{name}"
      expect(subject.www_url).to eq url
    end
  end

  describe "#refresh!" do
    let(:url) { "#{base_url}/refresh" }

    it "hits the branch Code Climate URL with a POST" do
      stub_request(:post, url).with(:api_token => api_token).to_return(:body => json_response.to_json)
      subject.refresh!

      expect(a_request(:post, url)).to have_been_made
    end
  end
end
