class Project < ActiveRecord::Base

  validates_presence_of :repo_url
  validates_uniqueness_of :repo_url
  validates_format_of :repo_url, :with => URI::regexp(%w(http https))

  has_and_belongs_to_many :users
  has_many :project_comments

  attr_reader :other_language

  def self.from(repo_url)
    new(repo_url: repo_url).update
  end

  def bookmarking_users
    self.users
  end

  def details
    @latest ||= Octokit.repo(repo_path)
    {
      open_issues_count: @latest.open_issues_count,
      last_activity: @latest.updated_at,
      created_at: @latest.created_at
    }
  rescue
    {}
  end

  def repo_path
    URI.parse(self.repo_url).path[1..-1]
  end

  def update
    if latest = Octokit.repo(repo_path)
      update_attributes(
        name:         latest.name,
        full_name:    latest.full_name,
        description:  latest.description,
        homepage:     latest.homepage,
        language:     latest.language,
        remote_id:    latest.id
      )
    end
  rescue Exception => e
    errors.add(:update, "failed from #{repo_path} with message #{e}")
  ensure
    return self
  end

end