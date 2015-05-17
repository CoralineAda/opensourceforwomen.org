# TODO language normalization for searchability

class PairProfile

  include Mongoid::Document
  include Mongoid::Timestamps

  field :languages
  field :skill_level
  field :special_interests
  field :availability
  field :time_zone
  field :notes

  belongs_to :user
  has_and_belongs_to_many :languages
  has_and_belongs_to_many :pair_profiles

  validates_presence_of :languages, :availability

  def username
    self.user.username
  end

end