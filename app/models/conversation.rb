class Conversation < ActiveRecord::Base

  has_many :messages
  has_and_belongs_to_many :participants, class_name: "User"

  def sorted_messages
    self.messages.order('created_at ASC')
  end

  def other_participant(participant)
    (self.participants.uniq - [participant]).first
  end

end