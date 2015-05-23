# TODO language normalization for searchability

class PairProfile

  include Mongoid::Document
  include Mongoid::Timestamps

  attr_accessor :other_language

  field :skill_level
  field :special_interests
  field :availability
  field :time_zone
  field :notes

  validates_uniqueness_of :user_id

  belongs_to :user
  has_and_belongs_to_many :languages
  has_and_belongs_to_many :pair_profiles

  def username
    self.user.username
  end

end