class Language < ActiveRecord::Base

  validates :name, presence: true
  validates_uniqueness_of :name

  has_and_belongs_to_many :extended_profiles

end