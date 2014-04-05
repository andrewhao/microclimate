require "spec_helper"

describe Microclimate::Response do
  subject { Microclimate::Response.new(json_hash) }

  context "for nested ruby hashes" do
    let(:json_hash) do
      { :foo => {:bar => [1, 2, 3]},
        :baz => "hello"}
    end

    it "turns attributes to methods" do
      expect(subject.baz).to eq "hello"
    end

    it "can call through nested methods" do
      expect(subject.foo.bar).to eq [1, 2, 3]
    end
  end
end
