class Invitation < ActiveRecord::Base

  validates :invitee_email, email_format: { message: 'has invalid format' }
  validates_presence_of :message
  validates_presence_of :invitee_email

  belongs_to :sender, class_name: "User"

end
