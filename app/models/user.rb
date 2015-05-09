# FIXME uniqueness test for usernames should be case-insensitive
class User

  include Mongoid::Document
  include Sorcery::Model

  authenticates_with_sorcery!

  field :username
  field :twitter_handle
  field :github_username
  field :accepts_coc, type: Boolean
  field :accepts_terms, type: Boolean

  index({ activation_token: 1 }, { unique: true, background: true })
  index({ email: 1 }, { unique: true, background: true })
  index({ username: 1 }, { unique: true, background: true })

  validates :password, length: { minimum: 8 }, :if => Proc.new { |user|
                !user.password.blank? ||
                !user.password_confirmation.blank? ||
                user.new_record?
              }
  validates :password, confirmation: true
  validates :email, uniqueness: true, email_format: { message: 'has invalid format' }
  validates :accepts_coc, acceptance: true
  validates :accepts_terms, acceptance: true
  validates_uniqueness_of :username

  def formatted_twitter_handle
    return unless self.twitter_handle
    "@#{self.twitter_handle}".gsub("@@", "@")
  end

end
