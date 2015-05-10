class Project

  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  field :full_name
  field :description
  field :homepage
  field :language
  field :repo_url
  field :remote_id

  has_many :contributors
  has_one  :owner
  has_and_belongs_to_many :users

  validates_presence_of :repo_url
  validates_uniqueness_of :repo_url

  def self.from(repo_url)
    new(repo_url: repo_url).update
  end

  def repo_path
    URI.parse(self.repo_url).path[1..-1]
  end

  def update
    begin
      latest = Octokit.repo repo_path
      update_attributes(
        name:         latest.name,
        full_name:    latest.full_name,
        description:  latest.description,
        homepage:     latest.homepage,
        language:     latest.language,
        remote_id:    latest.id
      )
    rescue Exception => e
      errors.add(:update, "failed from #{repo_path} with message #{e}")
    ensure
      return self
    end
  end

end