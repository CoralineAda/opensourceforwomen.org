require 'spec_helper'

describe Project do

  describe "#update" do

    let(:project) { Project.new }

    before do
      project.repo_url = "http://foo.com/foo/bar"
      project.stub(:update_attributes) { true }
    end

    it "fetches a repo" do
      Octokit.should_receive(:repo).with("foo/bar")
      project.update
    end

    it "handles errors" do
      Octokit.stub(:repo).and_raise("foo")
      project.update
      error = project.errors.full_messages.first
      expect(error.include?("foo")).to be_true
    end

  end

  describe "#repo_path" do

    let(:project) { Project.new(repo_url: "https://foo.com/Bantik/foo") }

    it "extracts the path from a URL" do
      expect(project.repo_path).to eq("Bantik/foo")
    end

  end

end