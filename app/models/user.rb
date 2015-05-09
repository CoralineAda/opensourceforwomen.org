# FIXME uniqueness test for usernames should be case-insensitive
class User

  include Mongoid::Document
  include Sorcery::Model

  authenticates_with_sorcery!

  field :username
  field :accepts_coc, type: Boolean
  field :accepts_terms, type: Boolean

  index({ activation_token: 1 }, { unique: true, background: true })

  validates :password, length: { minimum: 8 }
  validates :password, confirmation: true
  validates :email, uniqueness: true, email_format: { message: 'has invalid format' }
  validates_uniqueness_of :username
  validates :accepts_coc, acceptance: true
  validates :accepts_terms, acceptance: true

end
