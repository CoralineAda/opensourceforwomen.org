class Conversation < ActiveRecord::Base

  has_many :messages
  has_and_belongs_to_many :participants, class_name: "User"

  def sorted_messages
    self.messages.asc(:created_at)
  end

  def other_participant(participant)
    (self.participants - [participant]).first
  end

end