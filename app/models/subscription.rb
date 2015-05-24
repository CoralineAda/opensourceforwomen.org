class Subscription

  include Mongoid::Document
  include Mongoid::Timestamps

  field :email
  field :synced_to_mailchimp, :type => Boolean, :default => false

  attr_accessor :message

  belongs_to :user

  validates_presence_of :email
  validates_uniqueness_of :email
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  def register_with_mailchimp
    return unless api.api_key
    api.lists.subscribe(
      :id => ENV['MAILCHIMP_LIST_ID'],
      :email => {:email => self.email}
    )
    self.update_attribute(:synced_to_mailchimp, true)
  end

  def unsubscribe
    return unless self.user.subscribed
    api.lists.unsubscribe(
      :id => ENV['MAILCHIMP_LIST_ID'],
      :email => {:email => self.email},
      :delete_member => true,
      :send_notify => true
    )
  end

  def reset
    self.email = nil
    self.message = "Invalid email or already subscribed."
  end

  private

  def api
    @api ||= Gibbon::API.new(ENV['MAILCHIMP_API_KEY'])
  end

end