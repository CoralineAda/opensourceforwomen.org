class PairRequest

  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :sender, inverse_of: :sent_pair_requests, class_name: 'User'
  belongs_to :recipient, inverse_of: :received_pair_requests, class_name: 'User'

  field :accepted, type: Boolean, default: false
  field :rejected, type: Boolean, default: false
  field :message

  def self.pending
    where(accepted: false, rejected: false)
  end

  def self.recent
    where(:created_at.gte => (Date.today - 30.days))
  end

  def self.for_recipient(user)
    where(recipient_id: user.id)
  end

end