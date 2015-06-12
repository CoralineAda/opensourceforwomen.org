class PairRequest

  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'

  field :accepted, type: Boolean, default: false
  field :rejected, type: Boolean, default: false
  field :message

  def self.recent
    where(:created_at.gte => (Date.today - 30.days))
  end

  def self.for_recipient(user)
    where(recipient_id: user.id)
  end

end