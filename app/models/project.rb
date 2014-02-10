class Project

  include Mongoid::Document
  include Mongoid::Timestamps
  include Project::Github

  field :name
  field :full_name
  field :description
  field :homepage
  field :language
  field :repo_url
  field :remote_id

  # has_many :maintainers
  # has_many :signals
  # has_one  :owner

  validates_presence_of :repo_url
  validates_uniqueness_of :repo_url

  def self.import_from(repo_url)
    Project.new(repo_url: repo_url).update
  end

end