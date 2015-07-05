# FIXME uniqueness test for usernames should be case-insensitive
class User

  include Mongoid::Document
  include Mongoid::Timestamps
  include Sorcery::Model

  authenticates_with_sorcery!

  field :twitter_handle
  field :github_username
  field :accepts_coc, type: Boolean
  field :accepts_terms, type: Boolean
  field :subscribed, type: Boolean

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
  validates :accepts_coc, :acceptance => {:accept => true}
  validates :accepts_terms, :acceptance => {:accept => true}
  validates_uniqueness_of :username

  has_one :extended_profile
  has_one :subscription
  has_and_belongs_to_many :projects
  has_and_belongs_to_many :pair_partners, class_name: "User"
  has_many :sent_messages, inverse_of: :sender, class_name: "Message"
  has_many :incoming_messages, inverse_of: :recipient, class_name: "Message"

  attr_accessor :requested_username

  def formatted_twitter_handle
    return unless self.twitter_handle
    "@#{self.twitter_handle}".gsub("@@", "@")
  end

  def formatted_username
    return email unless username.present?
    username.gsub(/[^a-zA-Z 0-9]/u, "")
  end

  def subscribe_me
    self.subscribed
  end

  def subscribe_me=(value)
    # self.subscription ||= Subscription.find_or_create_by(email: self.email)
    # self.update_attribute(:subscribed, value)
    # if value && value == 1
    #   subscription.register_with_mailchimp
    # else
    #   subscription.unsubscribe
    #   subscription.destroy
    # end
  end

  def requested_username=(requested)
    self.username = requested.gsub(/[^a-zA-Z0-9 \-\_]/, '')
  end

  def unread_messages
    self.incoming_messages.unread
  end


end
