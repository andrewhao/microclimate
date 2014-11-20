require "spec_helper"

describe "repository management" do
  before(:all) do
    WebMock.allow_net_connect!
    @repo_id = "533329e76956801171001e7e"
    @client = Microclimate::Client.new :api_token => "321786539ec44cb4ae96b86e09209828416542fe"
    @repo = @client.repository_for @repo_id
  end

  after :all do
    WebMock.disable_net_connect!
  end

  it "gets the GPA of the repository" do
    expect(@repo.id).to eq @repo_id
  end

  it "triggers a refresh of the repository" do
    expect(@repo.refresh!).to eq true
  end

  it "grabs the most recent snapshot" do
    expect(@repo.last_snapshot).to be_a Microclimate::Snapshot
  end

  it "reports the GPA of a repo" do
    expect(@repo.last_snapshot.gpa).to be_kind_of Float
  end

  it "reports the time of last snapshot completion" do
    expect(@repo.last_snapshot.finished_at).to be_instance_of DateTime
  end
end
