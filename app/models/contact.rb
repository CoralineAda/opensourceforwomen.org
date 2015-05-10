class Contact

  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  field :email
  field :message

  validates :email, email_format: { message: 'has invalid format' }
  validates_presence_of :message
  validates_presence_of :name

  def headers
    {
      :subject => "OS4W: Contact Form",
      :to => "coraline@idolhands.com",
      :from => %("#{name}" <#{email}>)
    }
  end

  def sent_at
    self.created_at.strftime("%m/%d/%Y at %I:%M%p")
  end

end