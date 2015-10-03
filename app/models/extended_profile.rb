# TODO language normalization for searchability

class ExtendedProfile < ActiveRecord::Base

  attr_accessor :other_language

  delegate :avatar, to: :user
  delegate :gravatar_url, to: :user
  delegate :username, to: :user
  delegate :formatted_username, to: :user

  scope :mentors,       ->{ where(is_mentor: true) }
  scope :pair_partners, ->{ where(is_pair_partner: true) }

  validates_uniqueness_of :user_id

  belongs_to :user
  has_and_belongs_to_many :languages

end