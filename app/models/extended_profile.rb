# TODO language normalization for searchability

class ExtendedProfile

  include Mongoid::Document
  include Mongoid::Timestamps

  attr_accessor :other_language

  field :skill_level
  field :special_interests
  field :availability
  field :time_zone
  field :notes
  field :is_mentor, type: Boolean, default: false
  field :is_pair_partner, type: Boolean, default: false

  scope :mentors,       ->{ where(is_mentor: true) }
  scope :pair_partners, ->{ where(is_pair_partner: true) }

  validates_uniqueness_of :user_id

  belongs_to :user
  has_and_belongs_to_many :languages

  def username
    self.user.username
  end

end