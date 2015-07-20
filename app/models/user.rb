class User < ActiveRecord::Base

  authenticates_with_sorcery!

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
  has_many :conversations
  has_and_belongs_to_many :projects
  has_many :sent_messages, inverse_of: :sender, class_name: "Message"
  has_many :incoming_messages, inverse_of: :recipient, class_name: "Message"
  has_and_belongs_to_many :abuse_reports, inverse_of: :reporter
  has_and_belongs_to_many :abuse_reports, inverse_of: :offender
  has_and_belongs_to_many :invitations, inverse_of: :sender

  attr_accessor :requested_username

  def self.signed_in_users
    where(:last_logout_at < :last_activity_at)
  end

  def can_sign_in?
    ! self.is_frozen || self.is_admin
  end

  def is_signed_in?
    User.signed_in_users.map(&:id).include?(self.id)
  end

  def freeze_account
    self.update_attributes(is_frozen: true)
  end

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

  # def subscribe_me=(value)
  #   # self.subscription ||= Subscription.find_or_create_by(email: self.email)
  #   # self.update_attribute(:subscribed, value)
  #   # if value && value == 1
  #   #   subscription.register_with_mailchimp
  #   # else
  #   #   subscription.unsubscribe
  #   #   subscription.destroy
  #   # end
  # end

  def requested_username=(requested)
    self.username = requested.gsub(/[^a-zA-Z0-9 \-\_]/, '')
  end

  def unread_messages
    self.incoming_messages.unread
  end


end
