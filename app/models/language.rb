class Language

  include Mongoid::Document

  field :name

  validates_presence_of :name
  validates_uniqueness_of :name

  has_and_belongs_to_many :pair_profiles

end