class Language < ActiveRecord::Base

  validates :name, presence: true
  validates_uniqueness_of :name

  has_and_belongs_to_many :extended_profiles

  def project_count
    Project.where(language: self.name).count
  end

end