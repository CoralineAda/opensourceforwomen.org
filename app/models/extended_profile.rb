# TODO language normalization for searchability

class ExtendedProfile < ActiveRecord::Base

  attr_accessor :other_language

  scope :mentors,       ->{ where(is_mentor: true) }
  scope :pair_partners, ->{ where(is_pair_partner: true) }

  validates_uniqueness_of :user_id

  belongs_to :user
  has_and_belongs_to_many :languages

  def username
    self.user.username
  end

end