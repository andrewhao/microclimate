require "spec_helper"

describe Microclimate::Repository do
  let(:repo_id) { "my_repo_id" }
  let(:api_token) { "my_api_token" }
  let(:client) { mock("client", :api_token => api_token) }
  let(:url) { subject.host + "/api/repos/" + repo_id + "?api_token=" + api_token }
  let(:gpa) { 2.25 }
  let(:previous_gpa) { 2.50 }
  let(:last_snapshot) do
    {
      "last_snapshot" => {
        "gpa" => gpa
      }
    }
  end

  let(:previous_snapshot) do
    {
      "previous_snapshot" => {
        "gpa" => previous_gpa
      }
    }
  end

  let(:json_response) do
    {"id" => repo_id}.merge(last_snapshot).merge(previous_snapshot)
  end

  subject { described_class.new client, :repo_id => repo_id }

  describe "#new" do
    it "returns an instance of Repository" do
      expect(subject).to be_instance_of described_class
    end
  end

  describe "#ready?" do
    before :each do
      stub_request(:get, url).with(:api_token => api_token).to_return(:body => json_response.to_json)
    end

    context " with a snapshot" do
      it "returns true" do
        expect(subject).to be_ready
      end
    end

    context "without a snapshot" do
      let(:last_snapshot) { {} }

      it "returns false" do
        expect(subject).to_not be_ready
      end
    end
  end

  describe "#refresh!" do
    let(:url) { subject.host + "/api/repos/" + repo_id + "/refresh" }
    let(:json_response) do
      {"hello" => "world"}
    end

    before :each do
      stub_request(:post, url).with(:api_token => api_token).to_return(:body => json_response.to_json)
    end

    it "POSTs to /api/repos/:repo_id/refresh" do
      subject.refresh!

      expect(a_request(:post, url)).to have_been_made
    end
  end

  describe "#www_url" do
    it "returns the Code Climate HTML report" do
      url = "https://codeclimate.com/repos/#{repo_id}"
      expect(subject.www_url).to eq url
    end
  end

  describe "#id" do
    before :each do
      stub_request(:get, url).with(:api_token => api_token).to_return(:body => json_response.to_json)
    end

    it "returns the id from the response" do
      expect(subject.id).to eq repo_id
    end
  end

  context "branching" do
    let(:branch_name) { "my_branch" }

    describe "#branch_for" do
      it "returns a Branch" do
        expect(subject.branch_for(branch_name)).to be_instance_of Microclimate::Branch
      end
    end
  end

  describe "#gpa" do
    before :each do
      stub_request(:get, url).with(:api_token => api_token).to_return(:body => json_response.to_json)
    end

    it "returns the GPA of the last snapshot" do
      expect(subject.gpa).to eq gpa
    end
  end

  [:last_snapshot, :previous_snapshot].each do |snapshot_method|
    describe "##{snapshot_method}" do
      before :each do
        stub_request(:get, url).with(:api_token => api_token).to_return(:body => json_response.to_json)
      end

      context "without a snapshot" do
        let(snapshot_method) do
          {}
        end

        it "returns nil if no snapshot returned" do
          expect(subject.send(snapshot_method)).to be_nil
        end
      end

      it "returns a Snapshot if one exists" do
        expect(subject.send(snapshot_method)).to be_instance_of Microclimate::Snapshot
      end
    end
  end

  describe "#status" do
    before :each do
      stub_request(:get, url).with(:api_token => api_token).to_return(:body => json_response.to_json)
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
