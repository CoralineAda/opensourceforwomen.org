class Owner

  include Mongoid::Base

  has_many :projects

  field :login
  field :remote_id
  field :type

  def self.find_or_create_by(params={})
    where(params).first || create(params)
  end

  def id=(value)
    self.remote_id = value
  end

end