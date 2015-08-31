require 'spec_helper'

describe Project do

  describe "#update" do

    let(:project) { Project.new }

    before do
      project.repo_url = "http://foo.com/foo/bar"
      allow(project).to receive(:update_attributes).and_return(true)
    end

    it "fetches a repo" do
      allow(Octokit).to receive(:repo).with("foo/bar")
      project.update
    end

    it "handles errors" do
      expect(Octokit).to receive(:repo).and_raise("foo")
      project.update
      error = project.errors.full_messages.first
      expect(error.include?("foo")).to be_truthy
    end

  end

  describe "#repo_path" do

    let(:project) { Project.new(repo_url: "https://foo.com/Bantik/foo") }

    it "extracts the path from a URL" do
      expect(project.repo_path).to eq("Bantik/foo")
    end

  end

end