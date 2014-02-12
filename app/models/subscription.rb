class Subscription

  include Mongoid::Document
  include Mongoid::Timestamps

  field :email
  field :synced_to_mailchimp, :type => Boolean, :default => false

  attr_accessor :message

  validates_presence_of :email
  validates_uniqueness_of :email
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  def register_with_mailchimp
    return unless Gibbon::API.new.api_key
    begin
      Gibbon::API.new.lists.subscribe(:id => "ae537a59f9", :email => {:email => self.email})
      self.update_attribute(:synced_to_mailchimp, true)
    rescue Exception => e
      Rails.logger.error("!!! #{e} #{e.backtrace}")
    end
  end

  def reset
    self.email = nil
    self.message = "Invalid email or already subscribed."
  end

end