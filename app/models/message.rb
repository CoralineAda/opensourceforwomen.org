class Message
  include Mongoid::Document
  include Mongoid::Timestamps

  field :subject
  field :body
  field :is_read, type: Boolean, default: false

  scope :unread, ->{ where(is_read: false) }

  belongs_to :recipient, class_name: "User", inverse_of: :incoming_messages
  belongs_to :sender, class_name: "User", inverse_of: :sent_messages

  validates_presence_of :subject
  validates_presence_of :body

end